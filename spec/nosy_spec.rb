require 'nosy'

describe Nosy do

  let(:iphone_database) { File.join('spec', 'support', 'db', 'texts.sqlite') }
  let(:texts) { subject.new(iphone_database) }
  let(:parsed_texts) { Nosy.parse(File.join('spec', 'support', 'db', 'texts.sqlite'))}

  describe "#hunt" do

    it "should return the same results as a hunt" do
      Nosy.hunt.should == Nosy::Hunter.new.hunt
    end

  end

  describe "#new" do

    it "should return the same results as a search" do
      Nosy.new(iphone_database).texts.should == Nosy::Searcher.new(iphone_database).texts
    end

  end

  describe "#hunt_and_parse" do

    it "should get the database and parse it" do
      Nosy.hunt_and_parse.should == Nosy::Parser.new.parse(Nosy::Hunter.new.hunt)
    end

  end

  describe "#hunt_parse_and_output( output_type, to_file)" do

    it "should by default get the database, parse it, and output it as an html file" do
      Nosy.hunt_parse_and_output.should == Nosy::Output.new.to_html(Nosy::Parser.new.parse(Nosy::Hunter.new.hunt))
    end

    it "should get the database, parse it, and output it as json string" do
      Nosy.hunt_parse_and_output("json", false).should == Nosy::Output.new.to_json(Nosy::Parser.new.parse(Nosy::Hunter.new.hunt), false)
    end

    it "should get the database, parse it, and output it as json file" do
      Nosy.hunt_parse_and_output("json", true).should == Nosy::Output.new.to_json(Nosy::Parser.new.parse(Nosy::Hunter.new.hunt), true)
    end

    it "should get the database, parse it, and output it as an html file" do
      Nosy.hunt_parse_and_output("html").should == Nosy::Output.new.to_html(Nosy::Parser.new.parse(Nosy::Hunter.new.hunt))
    end

    it "should get the database, parse it, and output it as a csv file" do
      Nosy.hunt_parse_and_output("csv").should == Nosy::Output.new.to_csv(Nosy::Parser.new.parse(Nosy::Hunter.new.hunt))
    end

  end

  describe "#parse" do

    it "should return the same results as a parse" do
      Nosy.parse(iphone_database).should == Nosy::Parser.new.parse(iphone_database)
    end

  end

  describe "#can_parse?" do

    it "should return the same results as a parse" do
      Nosy.can_parse?(iphone_database).should == Nosy::Parser.new.can_parse?(iphone_database)
    end

  end

  describe "#output( output_type, to_file)" do


    it "should by default output it as an html file" do
      Nosy.output(parsed_texts).should == Nosy::Output.new.to_html(parsed_texts)
    end

    it "should output it as json string" do
      Nosy.output(parsed_texts, "json", false).should == Nosy::Output.new.to_json(parsed_texts, false)
    end

    it "should output it as json file" do
      Nosy.output(parsed_texts, "json", true).should == Nosy::Output.new.to_json(parsed_texts, true)
    end

    it "should output it as an html file" do
      Nosy.output(parsed_texts, "html").should == Nosy::Output.new.to_html(parsed_texts)
    end

    it "should output it as a csv file" do
      Nosy.output(parsed_texts, "csv").should == Nosy::Output.new.to_csv(parsed_texts)
    end

  end

end