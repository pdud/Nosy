require 'nosy'

describe Nosy::Hunter, "#hunt" do

  context "Mac OSX" do

    it "returns the location of a valid iphone database" do
      location = subject.hunt
      Nosy::Parser.new.can_parse?(location).should == true
    end
  end

end