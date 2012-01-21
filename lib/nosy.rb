require "nosy/hunter"
require "nosy/output"
require "nosy/parser"
require "nosy/searcher"

module Nosy

    def self.hunt
      Hunter.new.hunt
    end

    def self.hunt_and_parse
      Parser.new.parse(Hunter.new.hunt)
    end

    def self.hunt_parse_and_output(output_type="html", output_to_file=true)
      if output_type == "json"
        if output_to_file == true
          Output.new.to_json(parse(Hunter.new.hunt), true)
        else
          Output.new.to_json(parse(Hunter.new.hunt), false)
        end
      elsif output_type == "csv"
        Output.new.to_csv(parse(Hunter.new.hunt))
      else
        Output.new.to_html(parse(Hunter.new.hunt))
      end
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

    def self.output(texts, output_type="html", output_to_file=true)
      if output_type == "json"
        if output_to_file == true
          Output.new.to_json(texts, true)
        else
          Output.new.to_json(texts, false)
        end
      elsif output_type == "csv"
        Output.new.to_csv(texts)
      else
        Output.new.to_html(texts)
      end
    end
end