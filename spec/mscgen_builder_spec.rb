require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Mscgen::Builder do
  before do
    @builder = Mscgen::Builder.new
  end
  describe "#add_entity" do
    before do
      @name = 'foo'
    end
    subject { @builder.add_entity(@name) }
    it "should add Builder.entities" do
      lambda { @builder.add_entity('foo') }.should change(@builder.entities, :size).by(1)
    end
    it { should be_kind_of(Mscgen::Entity) }
  end

  describe "#find_or_add_entity" do
    subject { @builder.find_or_add_entity(@name) }
    context "when input new entity name" do
      it { should be_kind_of(Mscgen::Entity) }
      it "should add new Entity to Builder.entities" do
        lambda { subject }.should change(@builder.entities, :size).by(1)
      end
    end

    context "when input exist entity name" do
      before do
        # create @name entitiy
        @exist_entity = @builder.add_entity(@name)
      end
      it { should be_kind_of(Mscgen::Entity) }
      it "should return exist entity" do
        should equal @exist_entity
      end
      it "should not change Builder.entities" do
        lambda { subject }.should_not change(@builder.entities, :count)
      end
    end
  end

  describe "#add_message" do
    before do
      @ent1 = @builder.add_entity('a')
      @ent2 = @builder.add_entity('b')
    end
    subject { @builder.add_message(@msg) }
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
        lambda {subject}.should change(@builder.messages, :size).by(1)
      end
    end

    describe "#to_msc" do
    end

    describe "#build" do
    end
    

  end
end
