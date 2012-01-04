module Nosy

  class Parser

    module Imessage

      def sent_imessage( parsed_message, message )
        parsed_message.receiver = format_address(message[7])
        parsed_message.sender = "me"
      end

      def received_imessage( parsed_message, message )
        parsed_message.receiver = "me"
        parsed_message.sender = format_address(message[7])
      end

      def  sent_group_imessage( parsed_message, message )
        parsed_message.sender = "me"
        parsed_message.receiver = "group"
      end
    end
  end

end