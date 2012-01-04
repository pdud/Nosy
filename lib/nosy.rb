require "nosy/hunter"
require "nosy/parser"
require "nosy/searcher"

module Nosy

    def self.hunt
      Hunter.new.hunt
    end

    def self.hunt_and_parse
      Parser.new.parse(Hunter.new.hunt)
    end

    def self.new(file)
      Searcher.new(file)
    end

    def self.can_parse?(file)
      Parser.new.can_parse?(file)
    end

    def self.parse(file)
      Parser.new.parse(file)
    end
end