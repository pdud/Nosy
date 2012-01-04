module Nosy

  class Parser

    module Smsmessage

      def sent_sms_message( parsed_message, message )
        parsed_message.receiver = format_address(message[2])
        parsed_message.sender = "me"
      end

      def received_sms_message( parsed_message, message )
        parsed_message.receiver = "me"
        parsed_message.sender = format_address(message[2])
      end

    end
  end

end