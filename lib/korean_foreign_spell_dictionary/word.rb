module KoreanForeignSpellDictionary
  class Word
    attr_reader :id, :original, :korean, :nation, :relate, :mean, :reference
    def initialize(id, original, korean, nation)
      @id, @original, @korean, @nation = id, original, korean, nation
    end

    def attributes=(attributes)
      attributes.each do |name, value|
        instance_variable_set "@#{name}", value
      end
    end

    def to_hash
      {
        "original"  => @original,
        "korean"    => @korean,
        "nation"    => @nation,
        "relate"    => @relate,
        "mean"      => @mean,
        "reference" => @reference
      }
    end
  end
end
