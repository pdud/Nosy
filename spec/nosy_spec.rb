require 'nosy'


describe Nosy do

	let(:iphone_database) { File.join('spec', 'support', 'db', 'texts.sqlite') }
	let(:texts) { subject.new(iphone_database) }

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

end