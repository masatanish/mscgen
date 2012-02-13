module Mscgen
  # sequence entity object
  class Entity
    @@entity_count = 0

    # entity label
    attr_accessor:label

    def initialize(label)
      @label = Mscgen.escape(label.to_s)
      @eid = @@entity_count
      @@entity_count += 1
    end

    # return entity name
    def name
      "ent_#{@eid}"
    end

    # retrun mscgen format text
    def to_msc
      "#{name}[label=\"#{@label}\"]"
    end
  end
end
