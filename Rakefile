require 'rake/testtask'
require 'net/http'
require 'nokogiri'
require './lib/korean_foreign_spell_dictionary/word'
require 'yaml/store'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
end

task default: :test

LAST_PAGE = 5_768

task :list do
  store = YAML::Store.new 'data/dic.yml'
  store.transaction do
    (1..LAST_PAGE).each do |page|
      importer = ListImporter.new(page)
      importer.run
      importer.words.each do |word|
        store[word.id] = word.to_hash
      end
      puts "current_page : #{page}/#{LAST_PAGE}"
    end
  end
end

task :detail do
  store = YAML::Store.new 'data/dic.yml'
  store.transaction do
    total   = store.roots.size
    current = 0
    store.roots.each do |seq|
      current += 1
      if store[seq]['relate'].nil? &&
         store[seq]['mean'].nil? &&
         store[seq]['reference'].nil?
        importer = DetailImporter.new(seq)
        importer.run
        store[seq] = importer.word.to_hash
        puts "#{current}/#{total}"
      end
    end
  end
end

class DetailImporter
  URL = 'http://www.korean.go.kr/front/foreignSpell/foreignSpellView.do?forgn_seq=%s'
  attr_reader :doc, :word

  def initialize(seq)
    data  = Net::HTTP.get(URI(URL % seq))
    @doc  = Nokogiri::HTML(data)
    @word = KoreanForeignSpellDictionary::Word.new(seq)
  end

  def run
    word.attributes = attributes
  end

  private

  def attributes
    korean, original, nation, relate, mean, reference =
      doc.css('.board_view2 tbody tr td:eq(1)').map(&:text)
    {
      'original'  => original,
      'korean'    => korean,
      'nation'    => nation,
      'relate'    => relate,
      'mean'      => mean,
      'reference' => reference
    }
  end
end

class ListImporter
  URL = 'http://www.korean.go.kr/front/foreignSpell/foreignSpellList.do?pageIndex=%s'
  attr_reader :doc, :words

  def initialize(page)
    data   = Net::HTTP.get(URI(URL % page))
    @doc   = Nokogiri::HTML(data)
    @words = []
  end

  def run
    rows.each do |row|
      words << KoreanForeignSpellDictionary::Word.new(*row)
    end
  end

  private

  def rows
    trs.map do |tr|
      tr.css('td').map(&:text)
    end
  end

  def trs
    doc.css('.tbl_type01 tbody tr')
  end
end
