require 'nosy'

describe Nosy::Parser, "#can_parse?" do

	let(:acceptable_iphone_database) { File.join('spec', 'support', 'db', 'texts.sqlite') }
	let(:invalid_file_type_iphone_database) { File.join('spec', 'support', 'db', 'invalid_file_type_texts.txt') }
	let(:missing_table_iphone_database) { File.join('spec', 'support', 'db', 'missing_table_texts.sqlite') }
	let(:incorrect_format_iphone_database) { File.join('spec', 'support', 'db', 'incorrect_format_texts.sqlite') }
	let(:missing_iphone_database) { File.join('spec', 'support', 'db', 'this_file_does_not_exist.sqlite') }

	it "returns true for an iPhone Database" do
		subject.can_parse?(acceptable_iphone_database).should == true
	end

	it "returns false for a file that is not a database" do
		subject.can_parse?(invalid_file_type_iphone_database).should == false
	end

	it "returns false for a file that is missing the messages table" do
		subject.can_parse?(missing_table_iphone_database).should == false
	end

	it "returns false for a file that is missing the necessary fields in the messages table" do
		subject.can_parse?(incorrect_format_iphone_database).should == false
	end

	it "returns false for a file that is missing" do
		subject.can_parse?(missing_iphone_database).should == false
	end

end

describe Nosy::Parser, "#parse(file)" do

	let(:iphone_database) { File.join('spec', 'support', 'db', 'texts.sqlite') }
	let(:parsed) { subject.parse(iphone_database) }

	it "should parse each texts as a Messages" do
		parsed[0].should be_a_kind_of Message 
	end

	it "should parse the collection of texts as an Array" do
		parsed.should be_a_kind_of Array 
	end


	it "correctly parses the text" do
		parsed[0].message.should == "Hey it's Phil. I'm moving some stuff to next years apartment at the mo. But you left stuff here so you should come round later to grab it."
		parsed[3].message.should == "Hi :)"
	end

	context "SMS Messages" do

		it "correctly detects the message as an iMessage" do
			parsed[0].imessage.should == false
			parsed[1].imessage.should == false
			parsed[2].imessage.should == false
		end

		it "correctly parses the date" do
			parsed[0].date.should == 1273175931
		end

		describe "Sent from me" do

			it "correctly parses the sender" do
				parsed[0].sender.should == "me"
			end

			it "correctly parses the receiver" do
				parsed[0].receiver.should == "+1234567890"
			end
		
		end

		describe "Sent to me" do

			it "correctly parses the sender" do
				parsed[1].sender.should == "+1234567890"
			end

			it "correctly parses the receiver" do
				parsed[1].receiver.should == "me"
			end
		
		end

		describe "Sent from me, Failed, then Succeded" do

			it "correctly parses the sender" do
				parsed[2].sender.should == "me"
			end

			it "correctly parses the receiver" do
				parsed[2].receiver.should == "+1234567890"
			end

		end

		describe "Sent from me and Failed" do

			it "correctly parses the sender" do
				parsed[7].sender.should == "me"
			end

			it "correctly parses the receiver" do
				parsed[7].receiver.should == "+1234567890"
			end
		
		end

		describe "iMessage Failed and sent as SMS" do

			it "correctly parses the sender" do
				parsed[5].sender.should == "me"
			end

			it "correctly parses the receiver" do
				parsed[5].receiver.should == "+1234567890"
			end
		
		end

	end
	
	context "iMessages" do

		it "correctly detects the message as an iMessage" do
			parsed[3].imessage.should == true
			parsed[4].imessage.should == true
		end

		it "correctly parses the date" do
			parsed[3].date.should == 1318524672
			parsed[4].date.should == 1318524796
		end

		describe "Sent to me" do

			it "correctly parses the sender" do
			 parsed[3].sender.should == "user@gmail.com"
			end

			it "correctly parses the receiver" do
				parsed[3].receiver.should == "me"
			end

		end

		describe "Sent from me" do

			it "correctly parses the sender" do
			 parsed[4].sender.should == "me"
			end

			it "correctly parses the receiver" do
				parsed[4].receiver.should == "user@gmail.com"
			end

		end

		describe "Group message sent from me" do

			it "correctly parses the sender" do
				parsed[6].sender.should == "me"
			end

			it "correctly parses the receiver" do
				parsed[6].receiver.should == "group"
			end

		end


	end

	describe Nosy::Parser, "#format_address" do

		let(:parser) { subject }

		it "does not format nil addresses" do
			parser.send(:format_address, nil).should == nil
		end

		it "removes white space" do
			parser.send(:format_address, "my address").should == "myaddress"
		end

		it "removes parenthesis" do
			parser.send(:format_address, "my(address)").should == "myaddress"
		end

		it "removes seperators" do
			parser.send(:format_address, "my-address").should == "myaddress"
		end

		it "adds a + if it consists of all numbers" do
			parser.send(:format_address, "1 (234) 567-8901").should == "+12345678901"
		end

	end
end