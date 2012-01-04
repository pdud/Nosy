module Nosy

  class Parser

    module MessageSupport

      def find_all_messages( file ) 
        SQLite3::Database.new( file ).execute( "select rowid, date, address, text, flags, is_madrid, madrid_flags, madrid_handle from message" )
      end  
      
      def parse_imessage( parsed_message, message )
        parsed_message.imessage = true
        parsed_message.date = imessage_time_to_unixtime(message[1])

        if message[6] == 36869
          sent_imessage( parsed_message, message )
        elsif message[6] == 12289
          received_imessage( parsed_message, message )
        elsif message[6] == 32773
          sent_group_imessage( parsed_message, message )
        end
      end

      def  parse_sms_message( parsed_message, message )
        parsed_message.imessage = false
        parsed_message.date = message[1]

        if message[4] == 3 || message[4] == 35 || message[4] == 33 || message[4] == 16387
         sent_sms_message( parsed_message, message )        
        elsif message[4] == 2
          received_sms_message( parsed_message, message )
        end
      end

      private

        def imessage_time_to_unixtime( imessage_time )
          imessage_time + 978307200
        end

        def format_address(address)
          if !address.nil?
            address = address.gsub(/\s+|[()-]/, "")
            address =~ /^[0-9]+$/ ? "+"+address : address
          end
        end 
    end
  end

end