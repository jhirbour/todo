#!/usr/bin/env ruby

require 'thor'

class Todo < Thor
    # todo what is ,
    desc "list" , "this lists stuff"
    def list
        @tasks.each do |task|
            puts "[#{task.status}]\t#{task.id}\t\t#{task.name}"
        end
    end

    desc "add" , "add a task"
    def add(name)
        self.add_tasks [Todo::Task.new(:id => self.next_id, :name => name)]
        #self.add_tasks []
    end

    desc "done" , "complete a task"
    def done(id)
        self.find_task_by_id(id).done = true
        self.list
    end

    desc "delete" , "delete a task"
    def delete(id)
        self.delete_task_by_id(id)
        self.list
    end

    desc "gc" , "clean up completed tasks"
    def gc
        @tasks.select {|task| task.done}.map{|task| self.delete_task_by_id(task.id)}
        self.list
    end

    no_commands do
        def add_tasks(new_tasks)
            @tasks ||= []
            @tasks.concat new_tasks
        end

        def next_id
            @tasks ||= []
            @tasks.map(&:id).sort.last || 1
        end
        def find_task_by_id(id)
            @tasks.detect {|task| task.id == id} 
        end
        def delete_task_by_id(id)
            @tasks.delete_if {|task| task.id == id }
        end

    end

end

class Todo::Task
    #TODO needs status
    attr_accessor :id, :name, :done

    def initialize(options = [])
        self.id = options[:id]
        self.name = options[:name]
        self.done = false
    end

    def status
        if done 
            '#'
        else
            ' '
        end
    end
end

Todo.start(ARGV)
