# Nosy

**Output, backup, and read all your iPhone text messages.**

Nosy extracts text messages from the native iOS (iPhone, iPad) database stored on your computer after each backup and organizes it into an array of easily explorable messages.

Nosy returns an array of messages with the fields
	
* receiver
* sender
* message
* imessage (Boolean)
* date (contains a unix timestamp)


## Install

	$ gem install nosy

Or add Nosy to your Gemfile and run `bundle install`.

## Find and Parse
If you are on a Mac OSX system, Nosy (is nosy, and) will try to grab your iOS message database and parse it.

	all_texts = Nosy.hunt_and_parse

	all_texts.each do |text|
		text.receiver
		text.sender 
		text.message
		text.imessage
		text.date
	end


## Location
The location of the folder storing the iOS message backups in Mac OSX is

	$ ~/Library/Application Support/MobileSync/Backup/

Each of the folders will represent an Apple device. Within your desired device's folder, the iOS message database will be the file entitled `3d0d7e5fb2ce288813306e4d4636395e047a3d28`


### Hunt

If you are on Mac OSX running Nosy.hunt will return a String with the location of the first parseable iOS message database if there is one.

	require 'nosy'
	
	new_text_backup_file_location = Nosy.hunt


## Parsing 

If you pass in an iOS message database, Nosy can detect if a file can be parsed as an iPhone database.
	
	valid = Nosy.can_parse?(iphone_database_location)

Also, Nosy can parse the file and return an array of all available text messages.

	all_texts = Nosy.parse(iphone_database_location)

	all_texts.each do |text|
		text.receiver
		text.sender 
		text.message
		text.imessage
		text.date
	end

## Searching

Nosy can search through the texts in your iOS message database. Nosy searching supports any combination of the following keys:
	
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

Currently, Nosy is yet to...

* Properly handle MMS (group and media) messages.
* Let you search for two values in one key.
* Let you hunt for the iOS message database on systems other than Mac OSX.
* Support creating a backup file.
* Run on Heroku due to its dependency on Sqlite3.

## Acknowledgment

* For a similar implementation in Python check out [iPhone SMS Backup](https://github.com/toffer/iphone-sms-backup/)
* Inspiration from Gabe Berke-Williams's [Chat Stew](https://github.com/gabebw/chat_stew)
* [Mike Coutermarsh](https://github.com/mscoutermarsh)
* [Sarah Canieso](https://github.com/scanieso)
* [Eric Kelly](https://github.com/HeroicEric) - Providing additional SMS Databases
