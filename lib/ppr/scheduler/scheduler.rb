module PPR
  module Scheduler
    class Scheduler
      attr_accessor :start_date

      def initialize (tasks, user_data, start_date)
        @pending_hours = 0
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
          index = depth > 0 ? depth - 1 : depth
          if node.obj.duration.nil?
            node.obj.duration = 0
          end
          if @last_dates.length == 0
            start_date = @start_date
          elsif @last_dates[index].nil?
            start_date = @last_dates[index - 1]
          else
            start_date = @last_dates[index]
          end

          if node.obj.duration >= @pending_hours
            task_duration = node.obj.duration - @pending_hours
          else
            task_duration = node.obj.duration
          end
          duration = get_available_duration(node, start_date)
          days = (task_duration / duration).round
          end_date = start_date + days.days
          @pending_hours = duration - task_duration
          @pending_hours = 0 if @pending_hours < 0

          node.obj.start_date = start_date
          node.obj.end_date = end_date

          if (node.obj.duration % duration) != 0 or node.obj.duration == 0
            @last_dates[index] = end_date
          else
            @last_dates[index] = end_date + 1.day
          end
          ap depth.to_s + " => " + node.obj.name + ' (' + start_date.to_s + ' - ' + end_date.to_s + ')'
          puts start_date.to_s + " - " + end_date.to_s
          puts node.obj.duration.to_s + " hours task"
          puts days.to_s + " days from start"
          puts task_duration
          puts "\n"
        end

        def get_available_duration (node, date)
          6
        end

        def save_graph
          @graph.nodes.each do |i, node|
            #save node
            #save successors
          end
        end
      end
  end
end