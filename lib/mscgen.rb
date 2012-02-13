require File.join(File.dirname(__FILE__), 'mscgen/chart')
require File.join(File.dirname(__FILE__), 'mscgen/entity')
require File.join(File.dirname(__FILE__), 'mscgen/message')

module Mscgen
  def self.escape(str)
    str.gsub(/(["\n])/){ "\\" + $1 }
  end

  @@mscgen_path = "mscgen"

  # set mscgen command path
  def self.path=(path)
    @@mscgen_path = path
  end
  # return mscgen command path
  def self.path
    @@mscgen_path
  end
end
