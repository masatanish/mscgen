require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Mscgen" do
  describe "#escape" do
    it "should escape '\"'" do
      Mscgen.escape('abc"abc').should == 'abc\"abc'
    end
    it "should escape '\\n'" do
      Mscgen.escape("abc\nabc").should == "abc\\\nabc"
    end
  end
end
