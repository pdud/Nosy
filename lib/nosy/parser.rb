require 'sqlite3'
require 'nosy/parser/parse_checks'
require 'nosy/parser/message_support'
require 'nosy/parser/imessage'
require 'nosy/parser/smsmessage'

Message = Struct.new(:receiver, :sender, :message, :imessage, :date)

module Nosy

  class Parser
    
    include MessageSupport
    include ParseChecks
    include Imessage
    include Smsmessage

    def can_parse?(file)
      db = SQLite3::Database.new( file )
      results = has_messages_table(db)
      db != false && results != false ? is_iphone_database( results ) : false
    end

    def parse(file)
      find_all_messages( file ).map do |message|
        parsed_message = Message.new("", "", message[3], "", "")
        if message[5] == 1
          parse_imessage( parsed_message, message)
        else
          parse_sms_message( parsed_message, message)
        end
        parsed_message
      end
    end
  end

end