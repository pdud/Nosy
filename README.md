# Nosy
Nosy finds, parses and searches the iPhone's SMS database that is created on your machine each time you make a backup. Nosy returns an array of messages with the fields receiver, sender, message, imessage, and date. The date field contains a unix timestamp for the message.


## Install

	$ gem install nosy

Or add Nosy to your Gemfile and run bundle install.

## Finding
If you are on a Mac OSX system, Nosy can try to grab your SMS database. It will copy the file into your current directory and return the copy's location as a String.

	require 'nosy'
	
	new_text_backup_file_location = Nosy.hunt


## Parsing 

Nosy can detect if a file can be parsed and then parse it. Nosy will return an array of messages.
	
	require 'nosy'
	
	valid = Nosy.can_parse?(iphone_database_location)
	all_texts = Nosy.parse(iphone_database_location)

	all_texts.each do |text|
		text.receiver
		text.sender 
		text.message
		text.imessage
		text.date
	end

 

## Searching


Nosy can search through the texts in your iPhone SMS database. Nosy searching supports any combination of the following keys:
	
* receiver
* sender
* message
* imessage
* date - supports a Unix timestamp and an optional leading operator [ < , > , <= , >= ]

#	


	require 'nosy'

	nosty_texts = Nosy.new(iphone_database_location)
	
	# Array of texts where I am the sender
	my_sent_texts = nosty_texts.search(:sender => "me")
	
	# Array of texts where the date is less than 1273175931
	before_then_texts = nosty_texts.search(:date => "<1273175931")

	# Array of texts where I am the sender and the date is less than 1273175931
	before_then_texts = nosty_texts.search(:sender => "me", :date => "<1273175931")

## Contributions	
Contributions, improvements, and suggestions more than welcome! Please!

### Some Ideas

* Nosy currently does not properly handle MMS (group and media) messages. 
* Nosy currently does not let you search for two values in one key
* Nosy currently does not let you hunt for the SMS database on other systems than Mac OSX

## Acknowledgment

* Inspiration from Gabe Berke-Williams's [Chat Stew](http://https://github.com/gabebw/chat_stew)
* [Mike Coutermarsh](https://github.com/mscoutermarsh)
