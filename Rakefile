require 'rake/testtask'
require 'net/http'
require 'nokogiri'
require './lib/korean_foreign_spell_dictionary/word'
require 'yaml/store'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
end

task default: :test

LAST_PAGE = 5_768
class ListImporter
  URL = "http://www.korean.go.kr/front/foreignSpell/foreignSpellList.do?mn_id=96&pageIndex=%s"
  attr_reader :doc

  def initialize(page)
    data = Net::HTTP.get(URI(URL % page))
    @doc = Nokogiri::HTML(data)
  end

  def run
    store = YAML::Store.new "data/dic.yml"
    store.transaction do
      rows.each do |row|
        word = ::KoreanForeignSpellDictionary::Word.new(*row)
        store[word.id] = word.to_hash
      end
    end
  end

  private
    def rows
      trs.map do |tr|
        tr.css('td').map(&:text)
      end
    end

    def trs
      @trs ||= doc.css(".tbl_type01 tbody tr")
    end
end

task :list do
  (1..LAST_PAGE).each do |page|
    puts "current_page : #{page}/#{LAST_PAGE}"
    ListImporter.new(page).run
  end
end

take :detail do
  store = YAML::Store.new "data/dic.yml"
  store.transaction do
    store.each do |key, values|
    end
  end
end


# http://www.korean.go.kr/front/foreignSpell/foreignSpellList.do?mn_id=96&pageIndex=5768
