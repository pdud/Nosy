require 'nosy'
require 'spec_helper'

describe Nosy::Output, "#to_json( texts )" do

  let(:texts) { Nosy.parse(File.join('spec', 'support', 'db', 'texts.sqlite'))}

  context "#to_html" do

    before(:each) do
      @response = subject.to_html( texts )
      visit(@response)
    end

    it "should return the location to the created file" do
      @response.should == "#{Dir.pwd}/iphone-texts.html"
    end

    it "should create an html document with the correct texts messages" do
      page.all('article')[0].should have_content texts[0].message
    end

    it "should create an html document with the correct sender" do
      page.all('article ul li.sender')[0].should have_content texts[0].sender
      page.all('article ul li.sender')[1].should have_content texts[1].sender
    end

    it "should create an html document with the correct receiver" do
      page.all('article')[0].find('li')[1].should have_content texts[0].receiver
      page.all('article')[0].find('li')[1].should have_content texts[1].receiver
    end

    it "should create an html document with the imessage indicator" do
      page.all('article')[0].find('li')[1].should have_content "SMS"
      page.all('article')[3].find('li')[1].should have_content "iMessage"
    end

    it "should create an html document with an easy to understand date" do
      page.all('article')[0].should have_content "Thursday, May 6, 2010 at 3:58pm"
    end

    it "should include every text" do
      page.all('article').length.should == texts.length
    end

  end

  context "#to_json" do

    let(:json_texts_output) { JSON.parse( subject.to_json( texts ) ) }

    describe "Output" do

      it "should return a parsable json document" do
        json_texts_output['1'].should == {"date"=>1273176415, "sender"=>"+1234567890", "receiver"=>"me", "message"=>"Okie doke, i just have my fake final at 6 to do", "imessage"=>false}
      end

      it "should include every text" do
        json_texts_output.length.should == texts.length
      end

      it "should have a parsable date field" do
        json_texts_output['1']['date'].should == 1273176415
      end

      it "should have a parsable sender field" do
        json_texts_output['1']['sender'].should == "+1234567890"
      end

      it "should have a parsable receiver field" do
        json_texts_output['1']['receiver'].should == "me"
      end

      it "should have a parsable message field" do
        json_texts_output['1']['message'].should == "Okie doke, i just have my fake final at 6 to do"
      end

      it "should have a parsable imessage field" do
        json_texts_output['1']['imessage'].should == false
      end
    end

    describe "Output to file" do

      before(:each) do 
        @response = subject.to_json( texts, true ) 
        file = File.open("iphone-texts.json")
        @json_texts_file = JSON.parse( file.gets )
      end

      after(:each) { File.delete("iphone-texts.json")  }

      it "should return the location to the created file" do
        @response.should == "#{Dir.pwd}/iphone-texts.json"
      end

      it "should create a parsable json file" do
          @json_texts_file['1'].should == {"date"=>1273176415, "sender"=>"+1234567890", "receiver"=>"me", "message"=>"Okie doke, i just have my fake final at 6 to do", "imessage"=>false}
      end

      it "should have the same contents as the regular output" do
        @json_texts_file.should == json_texts_output
      end
    end
  end

  context "#to_csv" do

    let(:csv_texts_output) { CSV.parse( subject.to_csv( texts ) )}

    describe "Output to file" do

      before(:each) do 
        @response = subject.to_csv( texts, "file" )
        @csv = CSV.read( "iphone-texts.csv", { :headers => true })
      end

      after(:each) { File.delete("iphone-texts.csv")  }

      it "should return the location to the created file" do
        @response.should == "#{Dir.pwd}/iphone-texts.csv"
      end

      it "should create a csv file" do
        @csv[0][0].should == 1.to_s
        @csv[0][1].should == texts[0].date.to_s
        @csv[0][2].should == texts[0].sender
        @csv[0][3].should == texts[0].receiver
        @csv[0][4].should == texts[0].message
        @csv[0][5].should == texts[0].imessage.to_s
      end

      it "should include every text" do
        @csv.length.should == texts.length
      end

    end
  end

end
