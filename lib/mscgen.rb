require File.join(File.dirname(__FILE__), 'mscgen/builder')
require File.join(File.dirname(__FILE__), 'mscgen/entity')
require File.join(File.dirname(__FILE__), 'mscgen/message')

module Mscgen
  def self.escape(str)
    str.gsub(/(["\n])/){ "\\" + $1 }
  end
end
