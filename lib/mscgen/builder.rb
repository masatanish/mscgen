require 'tempfile'

module Mscgen
  class Builder
    @@mscgen_path = "mscgen"

    # set mscgen command path
    def self.mscgen_path=(path)
      @@mscgen_path = path
    end
    # return mscgen command path
    def self.mscgen_path
      @@mscgen_path
    end

    # sequence chart width
    attr_accessor :witdh

    # array of Mscgen::Entity
    attr_reader :entities

    # array of messages
    attr_reader :messages

    def initialize(width=nil)
      @entities = []
      @messages = []
      @width = width
    end

    # add entity to builder
    def add_entity(name)
      entity = Entity.new(name)
      @entities << entity
      return entity
    end

    # find entity from builder or add entity to builder
    def find_or_add_entity(name)
      entity = @entities.find {|e| e.label == name.to_s }
      if entity.nil?
        self.add_entity(name)
      else
        entity
      end
    end

    # add messages to builder..
    # _msg_ should respond to 'msc_text'
    def add_message(msg)
      raise ArgumentError unless msg.respond_to?(:to_msc)
      @messages << msg
      msg
    end

    # return mscgen format script
    def to_msc
      opt = get_opt
      ent_text = @entities.map{|e| e.to_msc }.join(', ')
      msg_text = @messages.map{|m| m.to_msc }.join(";\n  ")

      return MSC_TEMPLATE % [opt, ent_text, msg_text]
    end

    # execute mscgen command
    def build(filename, type=nil)
      text = msc_text
      execute_msc_cmd(text, filename, type)
      text
    end

    MSC_TEMPLATE = <<-"EOS"
# MSC for some fictional process
msc {
  %s

# entities
  %s;

# messages
  %s;
}
EOS

    def get_opt # :nodoc:
      unless @width.nil?
        "width=#{@width};"
      else
        ""
      end
    end
    private :get_opt

    FILE_TYPE = { # :nodoc:
      :png => "png",
      :svg => "svg",
      :eps => "eps",
      :ismap => "ismap",
    }
    def execute_msc_cmd(text, filename, type=nil) # :nodoc:
      f = Tempfile.new('mscgen')
      f.write(text)
      f.close
      type_str = FILE_TYPE.fetch(type, "png")
      system("#{@@mscgen_path} -T #{type_str} -o #{filename} -i #{f.path}")
    ensure
      f.close(true) # delete temporary file
    end
    private :execute_msc_cmd
  end
end
