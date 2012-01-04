require 'nosy'

describe Nosy::Searcher, "#new" do

  let(:iphone_database) { File.join('spec', 'support', 'db', 'texts.sqlite') }
  let(:texts) { Nosy::Searcher.new( iphone_database ) }

  it "should create a Nosy::Searcher class" do
    texts.should be_a_kind_of Nosy::Searcher
  end

  it "should fill texts" do
    texts.texts.should_not be nil
  end

  it "should fill texts with Messages" do
    texts.texts[0].should be_a_kind_of Message 
  end

end

describe Nosy::Searcher, "#search" do

  let(:iphone_database) { File.join('spec', 'support', 'db', 'texts.sqlite') }
  let(:texts) { Nosy::Searcher.new( iphone_database ) }

  it "should return all texts if no filters are passed in" do
    texts.search().count.should == 8
    texts.search().should == Nosy::Parser.new.parse( iphone_database )
  end

  it "should be searchable by sender" do
    search = texts.search(:sender => "me").each do |text|
      text.sender.should == "me"
    end
    search.count.should_not == 0
  end

  it "should be searchable by receiver" do
    search = texts.search(:receiver => "me").each do |text|
      text.receiver.should == "me"
    end
    search.count.should_not == 0
  end

  it "should be searchable by type of imessage" do
    search = texts.search(:imessage => true).each do |text|
      text.imessage.should == true
    end
    search.count.should_not == 0
  end

  it "should be searchable by text of message (full text)" do
    search = texts.search(:message => "Here :)").each do |text|
      text.message.should == "Here :)"
    end
    search.count.should_not == 0
  end

  it "should be searchable by date of message" do
    search = texts.search(:date => "1320880443").each do |text|
      text.date.should == 1320880443
    end
    search.count.should_not == 0
  end

  it "should be searchable by more than one field" do
    search = texts.search(:sender => "me", :message => "Here :)").each do |text|
      text.sender.should == "me"
      text.message.should == "Here :)"
    end
    search.count.should_not == 0
  end

  it "should be searchable after a given date" do
    search = texts.search(:date => ">1318524672").each do |text|
      Time.at(text.date).should > Time.at(1318524672)
    end
    search.count.should_not == 0
  end

  it "should be searchable before a given date" do
    search = texts.search(:date => "<1320880443").each do |text|
      Time.at(text.date).should < Time.at(1320880443)
    end
    search.count.should_not == 0
  end

  it "should be searchable after and equal to a given date" do
    search = texts.search(:date => ">=1318524672").each do |text|
      Time.at(text.date).should >= Time.at(1318524672)
    end
    search.count.should_not == 0
  end

  it "should be searchable before and equal to a given date" do
    search = texts.search(:date => "<=1320880443").each do |text|
      Time.at(text.date).should <= Time.at(1320880443)
    end
    search.count.should_not == 0
  end

end