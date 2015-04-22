module PPR
  module Scheduler
    class Graph
      def initialize
        @nodes = {}
      end

      def add_node(node)
        @nodes[node.id] = node if @nodes[node.id].nil?
      end

      def add_edge(predecessor_id, successor_id)
        @nodes[predecessor_id].add_edge(@nodes[successor_id])
      end

      def nodes
        @nodes
      end

      def [](id)
        @nodes[id]
      end
    end
  end
end