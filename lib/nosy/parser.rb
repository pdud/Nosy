require 'sqlite3'

Message = Struct.new(:receiver, :sender, :message, :imessage, :date)

module Nosy

	class Parser

		def can_parse?(file)
			begin
				db = SQLite3::Database.new( file )
				begin
					results = db.execute2( "select * from message LIMIT 1" )
					results.map do |header|
						if ( header[0] == "ROWID" && header[1] == "address" && header[2] == "date" && header[3] == "text" && header[4] == "flags" && header[16] == "read")
							return true
						else
							return false
						end
					end
				rescue SQLite3::SQLException
					return false
				end
			rescue SQLite3::NotADatabaseException
				return false
			end

		end

		def parse(file)
			db = SQLite3::Database.new( file )
			all_messages = db.execute( "select * from message" )

			all_messages.map do |message|

				# http://www.slideshare.net/hrgeeks/iphone-forensics-without-the-iphone
				# http://www.scip.ch/?labs.20111103

				parsed_message = Message.new("", "", message[3], "", "")

				## If it is an iMessage
				if message[29] == 1
					parsed_message.imessage = true
					parsed_message.date = message[2] + 978307200
						
					# Sent an iMessage
					if message[25] == 36869
						parsed_message.receiver = format_address(message[18])
						parsed_message.sender = "me"

					# Recieved an iMessage
					elsif message[25] == 12289
						parsed_message.receiver = "me"
						parsed_message.sender = format_address(message[18])

					# Sent a group iMessage
					elsif message[25] == 32773
						parsed_message.sender = "me"
						parsed_message.receiver = "group"
					end

				## It is an SMS
				else

					parsed_message.imessage = false
					parsed_message.date = message[2]

					# Sent SMS
					if message[4] == 3
						parsed_message.receiver = format_address(message[1])
						parsed_message.sender = "me"
					
					# Recieved an SMS
					elsif message[4] == 2
						parsed_message.receiver = "me"
						parsed_message.sender = format_address(message[1])

					# Sent SMS on retry
					elsif message[4] == 35
						parsed_message.receiver = format_address(message[1])
						parsed_message.sender = "me"

					# SMS Failed
					elsif message[4] == 33
						parsed_message.receiver = format_address(message[1])
						parsed_message.sender = "me"

					# iMessage Failed and sent as SMS
					elsif message[4] == 16387
						parsed_message.receiver = format_address(message[1])
						parsed_message.sender = "me"
					end

				end
	 
	    	parsed_message
	    end
		end

		private
			def format_address(address)
				if !address.nil?
					address = address.gsub(/\s+|[()-]/, "")
					address =~ /^[0-9]+$/ ? "+"+address : address
				end
			end

	end

end