# Nosy
###### Output, backup, and read all your iPhone text messages.

Nosy extracts text messages from the native iOS (iPhone, iPad) database stored on your computer automatically after each backup and organizes it into an array of easily explorable messages.

Nosy returns an array of messages with the fields receiver, sender, message, imessage, and date. The date field contains a unix timestamp for the message.


## Install

	$ gem install nosy

Or add Nosy to your Gemfile and run bundle install.


## Finding
If you are on a Mac OSX system, Nosy can try to grab your SMS database. It will return a String with the location of the iPhone SMS database.

	require 'nosy'
	
	new_text_backup_file_location = Nosy.hunt

If you have multiple phone's it will grab the first parseable file.

### Location
The location of the folder storing the iPhone backups in Mac OSX is

	$ ~/Library/Application Support/MobileSync/Backup/

Each of the folders will represent an Apple device. Within your desired device the SMS database will be the file with the title `3d0d7e5fb2ce288813306e4d4636395e047a3d28`


## Parsing 

Nosy can detect if a file can be parsed as an iPhone database.
	
	valid = Nosy.can_parse?(iphone_database_location)

Nosy can also parse the file, returning an array of all available text messages.

	all_texts = Nosy.parse(iphone_database_location)

	all_texts.each do |text|
		text.receiver
		text.sender 
		text.message
		text.imessage
		text.date
	end

## Find and Parse

Nosy also includes a convenience method that combines finding and parsing.

	all_texts = Nosy.hunt_and_parse

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
* Nosy currently does not support creating a backup file.
* Nosy currently does not run on Heroku due to it's dependency on Sqlite3.

## Acknowledgment

* For a similar implementation in Python check out [iPhone SMS Backup](https://github.com/toffer/iphone-sms-backup/)
* Inspiration from Gabe Berke-Williams's [Chat Stew](https://github.com/gabebw/chat_stew)
* [Mike Coutermarsh](https://github.com/mscoutermarsh)
* [Sarah Canieso](https://github.com/scanieso)
* [Eric Kelly](https://github.com/HeroicEric) - Providing additional SMS Databases
