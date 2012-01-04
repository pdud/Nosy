module Nosy

  class Searcher
    attr_accessor :texts

    def initialize( file )
      @texts = Parser.new.parse( file )
    end

    def search(filters={})

      @texts.select do |text|
        filters.all?{ |key, value| key == :date ? filter_dates(key, value, text) : text[key] == value }
      end
    end

    private

    def filter_dates( key, value, text )
      if value[1] == "="
        value[0] == ">" ? Time.at(text[key]) >= Time.at(value[2..-1].to_i) : Time.at(text[key]) <= Time.at(value[2..-1].to_i)
      else
        if value[0] == ">"
          Time.at(text[key]) > Time.at(value[1..-1].to_i)
        elsif value[0] == "<"
          Time.at(text[key]) < Time.at(value[1..-1].to_i)
        else
          Time.at(text[key]) == Time.at(value.to_i)
        end
      end
    end
  
  end

end