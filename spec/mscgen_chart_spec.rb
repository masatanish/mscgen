require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Mscgen::Chart do
  before do
    @chart = Mscgen::Chart .new
  end
  describe "#add_entity" do
    before do
      @name = 'foo'
    end
    subject { @chart.add_entity(@name) }
    it "should add Chart.entities" do
      lambda { @chart.add_entity('foo') }.should change(@chart.entities, :size).by(1)
    end
    it { should be_kind_of(Mscgen::Entity) }
  end

  describe "#find_or_add_entity" do
    subject { @chart.find_or_add_entity(@name) }
    context "when input new entity name" do
      it { should be_kind_of(Mscgen::Entity) }
      it "should add new Entity to Chart.entities" do
        lambda { subject }.should change(@chart.entities, :size).by(1)
      end
    end

    context "when input exist entity name" do
      before do
        # create @name entitiy
        @exist_entity = @chart.add_entity(@name)
      end
      it { should be_kind_of(Mscgen::Entity) }
      it "should return exist entity" do
        should equal @exist_entity
      end
      it "should not change Chart.entities" do
        lambda { subject }.should_not change(@chart.entities, :count)
      end
    end
  end

  describe "#add_message" do
    before do
      @ent1 = @chart.add_entity('a')
      @ent2 = @chart.add_entity('b')
    end
    subject { @chart.add_message(@msg) }
    context "with not Message object" do
      before do
        @msg = "aaa"
      end
      it do
        lambda {subject}.should raise_error(ArgumentError)
      end
    end
    context "with Message object" do
      before do
        @msg = Mscgen::Message.new(@ent1, @ent2, 'foobar')
      end
      it { should be_kind_of(Mscgen::Message) }
      it do
        lambda {subject}.should change(@chart.messages, :size).by(1)
      end
    end

    describe "#to_msc" do
    end

    describe "#to_img" do
    end
    

  end
end
