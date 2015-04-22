module PPR
  module Scheduler
    class Scheduler
      attr_accessor :start_date

      def initialize (tasks, user_data, start_date)
        @last_dates = []
        @tasks = tasks
        @start_date = start_date
        @user_data = user_data
        @graph = Graph.new
        @tasks.each do |task|
          @graph.add_node(Node.new(task, task.original_id))
          unless task.predecessor.nil?
            @graph.add_node(Node.new(task, task.predecessor))
            @graph.add_edge(task.predecessor, task.original_id)
          end
        end
      end

      def set_dates
        @graph.nodes.each do |i, node|
          set_node_date(node, 0) unless node.discovered
        end
        ap @last_dates
      end

      private
        def set_node_date (node, depth)
          node.discovered = true
          set_depth_date(node, depth)
          node.successors.each do |newNode|
            unless newNode.discovered
              set_node_date(newNode, depth + 1)
            end
          end
        end

        def set_depth_date (node, depth)
          ap depth.to_s + " => " + node.obj.name
          unless node.obj.duration.nil?
            if @last_dates.length == 0
              start_date = @start_date
            elsif depth > 0 and @last_dates[depth].nil?
              start_date = @last_dates[depth - 1]
            else
              start_date = @last_dates[depth]
            end
            duration = get_available_duration(node, start_date)
            days = (node.obj.duration / duration).ceil
            end_date = @start_date + days.days

            node.obj.start_date = start_date
            node.obj.end_date = end_date

            if (node.obj.duration % duration) == 0
              @last_dates[depth] = end_date + 1.day
            else
              @last_dates[depth] = end_date
            end
          end
        end

        def get_available_duration (node, date)
          6
        end
      end
  end
end