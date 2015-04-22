module PPR
  module Scheduler
    class Node
      attr_reader :id
      attr_accessor :discovered

      def initialize(obj, id)
        @obj = obj
        @id = id
        @successors = []
        @discovered = false
      end

      def is_discovered?
        @discovered
      end

      def add_edge(successor)
        @successors << successor
      end

      def successors
        @successors
      end

      def obj
        @obj
      end

      def to_s
        "#{@id} -> [#{@successors.map(&:id).join(' ')}]"
      end
    end
  end
end