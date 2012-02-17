module Mscgen
  class Message
    class UnknownAllowType < StandardError; end

    # acceptable allow type definition
    ALLOW_TYPE = {
      :messege => "->",
      :method => "=>",
      :method_return => ">>",
      :callback => "=>>",
      :emph_message => ":>",
      :lost_message => "-x",
    }


    attr_reader :label, :from, :to

    # _from_:: a entity which message from
    # _to_:: a entity which message to 
    # _label_:: message string
    # _options_:: supports :type, :linecolor, :textcolor attributes
    def initialize(from, to, label=nil, options={})
      @from = from
      @to = to
      @label = Mscgen.escape(label.to_s) unless label.nil?
      @options = (options or {})
      raise ArgumentError unless @options.kind_of?(Hash)
      raise UnknownAllowType unless ALLOW_TYPE.has_key?(@options.fetch(:type, :method))
    end

    # return mscgen format text
    def to_msc
      message = "#{@from.name} #{allow} #{@to.name}"
      message += option_string
      message
    end

    def option_string # :nodoc:
      opt_arr = []
      opt_arr <<  "label=\"#{@label}\"" if @label
      opt_arr << "linecolor=\"#{@options[:linecolor]}\"" if @options[:linecolor]
      opt_arr << "textcolor=\"#{@options[:textcolor]}\"" if @options[:textcolor]
      if opt_arr.size > 0
        "[ #{opt_arr.join(", ")} ]"
      else
        ""
      end
    end
    protected :option_string

    # determine allow shape
    def allow # :nodoc:
      ALLOW_TYPE.fetch(@options[:type], '->')
    end
    protected :allow
  end
end
