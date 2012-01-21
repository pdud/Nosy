require 'nosy/output/html_helpers'
require 'json'
require 'csv'

module Nosy

  class Output
    include HtmlHelpers

    def to_html( texts )
      File.open("iphone-texts.html","w") do |f|
        generate_html(f, texts)
      end
      "#{Dir.pwd}/iphone-texts.html"
    end

    def  to_json( texts, file=false )
      hash = to_hash(texts)

      if file == true
        File.open("iphone-texts.json","w") do |f|
          f.write(hash.to_json)
        end
        "#{Dir.pwd}/iphone-texts.json"
      else
        hash.to_json
      end
    end

    def to_csv( texts, output=nil )
      CSV.open("iphone-texts.csv", "w") do |csv|
        csv << ["id", "date", "sender", "receiver", "message", "imessage"]
        texts.each_with_index do |text, index|
          csv << [index+1, text.date, text.sender, text.receiver, text.message, text.imessage]
        end
      end
      "#{Dir.pwd}/iphone-texts.csv"
    end

    def to_hash (texts)
      hash = {}
      texts.each_with_index do |m, index|
        hash["#{index}"] = { date: m.date, sender: m.sender, receiver: m.receiver, message: m.message, imessage: m.imessage }
      end
      hash
    end
  end

end