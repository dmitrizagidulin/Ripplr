module Ripplr
  class Criteria

    def initialize(klass, indexer=Ripplr::Indexers::Ripple)
      @indexer = indexer
      @target = klass
    end

    def where(condition)
      self.condition = condition
      self
    end

    def each(&block)
      results.each do |result|
        yield result
      end
    end

    def size
      results.size
    end
    alias :length :size
    alias :count :size

    def to_a
      results
    end

    def execute
      return @target.list if condition.nil?

      @indexer.search @target, conditions
    end

    private
    def results
      @results ||= execute
      @results
    end

    def condition
      @condition
    end

    def condition=(value)
      @condition = { @target.queryable_field(value.keys.first) => value.values.first }
    end

    def conditions
      "#{condition.keys.first}: \"#{condition.values.first}\""
    end

  end
end
