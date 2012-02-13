require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Mscgen::Message do
  before do
    @ent1 = Mscgen::Entity.new('abc')
    @ent2 = Mscgen::Entity.new('def')
    @label = "label_str"
  end

  describe "#initialize" do
  subject { Mscgen::Message.new(@ent1, @ent2, @label) }
    it { should be_kind_of(Mscgen::Message) }
  end
  describe "#from" do
    subject { Mscgen::Message.new(@ent1, @ent2, "abc").from }
    it { should equal @ent1 }
  end
  describe "#to" do
    subject { Mscgen::Message.new(@ent1, @ent2, "abc").to }
    it { should equal @ent2 }
  end
  describe "#label" do
    subject { Mscgen::Message.new(@ent1, @ent2, @label).label }
    it { should eq @label }
    context "when label string includes special charactor" do
      it "should escape special char" do 
        @label = 'abcabc"abc'
        subject.should eq 'abcabc\"abc'
      end
    end
  end

  describe "#to_msc" do
    subject { Mscgen::Message.new(@ent1, @ent2, @label, @option).to_msc }
    context "with no label and no options" do
      before do
        @label = nil
        @option = {}
      end
      it { should == "#{@ent1.name} -> #{@ent2.name}" }
    end
    context "with label string and no options" do
      before do
        @label = "foo"
        @option = {}
      end
      it { should == "#{@ent1.name} -> #{@ent2.name}[ label=\"foo\" ]" }
    end
    context "with option { :type => :method }" do
      before do
        @label = "foo"
        @option = {:type => :method }
      end
      it { should == "#{@ent1.name} => #{@ent2.name}[ label=\"foo\" ]" }
    end
  end

  describe "#option_string" do
    subject { Mscgen::Message.new(@ent1, @ent2, @label, @option).send(:option_string) }
    context "only label" do
      before do
        @label = "abcabc"
        @option = {}
      end
      it { should == "[ label=\"abcabc\" ]" }
    end

    context "with label and option{:linecolor => '#ff0000'}" do
      before do
        @label = "abcabc"
        @option = {:linecolor => '#ff0000' }
      end
      it { should == "[ label=\"abcabc\", linecolor=\"#ff0000\" ]" }
    end
    context "with label and option{:linecolor => '#ff0000', :textcolor => '#00ff00' }" do
      before do
        @label = "abcabc"
        @option = {:linecolor => '#ff0000', :textcolor => '#00ff00' }
      end
      it { should == "[ label=\"abcabc\", linecolor=\"#ff0000\", textcolor=\"#00ff00\" ]" }
    end

    context "with unknown options" do
      before do
        @label = "abcabc"
        @option = {:foo => 'abc', :linecolor => '#ff0000' }
      end
      it "should ignore unknown options" do
        subject.should == "[ label=\"abcabc\", linecolor=\"#ff0000\" ]"
      end
    end
  end
end

