module PPR
  module Scheduler
    class Node
      attr_reader :id
      attr_accessor :discovered
      attr_accessor :start_date
      attr_accessor :due_date

      def initialize(obj, id)
        @obj = obj
        @id = id
        @successors = []
        @discovered = false
        @start_date = nil
        @due_date = nil
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

      def start_date=(date)
        @obj.start_date = date
        @start_date = date
      end

      def end_date=(date)
        @obj.end_date = date
        @due_date = date
      end

      def to_s
        "#{@id} -> [#{@successors.map(&:id).join(' ')}] => #{@start_date} - #{@end_date}"
      end
    end
  end
end