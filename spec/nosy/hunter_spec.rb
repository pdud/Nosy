require 'nosy'

describe Nosy::Hunter, "#hunt" do

	context "Mac OSX" do

		it "creates a new file called " do
			begin
				FileUtils.remove_file(File.join(File.expand_path("#{Dir.pwd}"), "texts.sqlite"))
			rescue
			end

			Dir.glob(File.join(File.expand_path("#{Dir.pwd}"), "texts.sqlite")).length.should == 0
			subject.hunt
			Dir.glob(File.join(File.expand_path("#{Dir.pwd}"), "texts.sqlite")).length.should == 1
		end

		it "creates a valid iphone database" do
			subject.hunt
			Nosy::Parser.new.can_parse?(File.join(File.expand_path("#{Dir.pwd}"), "texts.sqlite")).should == true
		end

		it "returns the location of the new iphone sms database" do
			subject.hunt.should == "#{Dir.pwd}/texts.sqlite"
		end
	end

end