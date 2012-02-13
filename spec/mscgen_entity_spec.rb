require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Mscgen::Entity do
  before do
    @label = "entity_label"
    @entity = Mscgen::Entity.new("entity_label") 
  end
  subject { @entity }
  describe "#new" do
    it { should be_kind_of(Mscgen::Entity) }
    it "label should be set" do
      subject.label.should == "entity_label"
    end
    it "should have unique id" do
      entity = Mscgen::Entity.new("label")
      entity.name.should_not eq @entity.name
      entity = Mscgen::Entity.new("label")
      entity.name.should_not eq @entity.name
    end
  end

  describe "#label=" do
    it do
      lambda {
        @entity.label = "label2"
      }.should change(@entity, :label).from("entity_label").to("label2")
    end
  end
  describe "#label" do
    it { subject.label.should eq "entity_label" }
    it "should escape special chars" do
      @entity.label = 'abcabc\"'
      @entity.label.should eq 'abcabc\"'
    end
  end
  describe "#name" do
    it { subject.name.should match(/ent_\d+/) }
  end
  describe "#to_msc" do
    it { subject.to_msc.should match(/ent_\d+\[label=\"#{@label}\"\]/) }
  end

end
