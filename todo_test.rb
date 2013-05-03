require 'minitest/autorun'
require './todo'


describe Todo do
    before do
        @todo = Todo.new
    end

    describe 'list' do
        it 'prints all tasks' do
            @todo.add_tasks [Todo::Task.new(:id => 1, :name => 'do stuff1'), Todo::Task.new(:id => 2, :name => 'do stuff2')]
            proc { @todo.list }.must_output "[ ]\t1\t\tdo stuff1\n[ ]\t2\t\tdo stuff2\n"
        end
    end
    describe 'add'  do
        it 'adds a task' do
            @todo.add('do an add')
            proc { @todo.list }.must_output "[ ]\t1\t\tdo an add\n"
        end
    end
    describe 'delete'  do
        it 'delete a task' do
            @todo.add_tasks [Todo::Task.new(:id => 1, :name => 'do stuff1'), Todo::Task.new(:id => 2, :name => 'do stuff2')]
            proc { @todo.delete(2) }.must_output "[ ]\t1\t\tdo stuff1\n"
        end
    end

    describe 'done'  do
        it 'I done a task (harwinton)' do
            @todo.add_tasks [Todo::Task.new(:id => 1, :name => 'do stuff1'), Todo::Task.new(:id => 2, :name => 'do stuff2')]
            proc { @todo.done(2) }.must_output "[ ]\t1\t\tdo stuff1\n[#]\t2\t\tdo stuff2\n"
        end
    end

    describe 'gc'  do
        it 'delete tasks that are done' do
            @todo.add_tasks [Todo::Task.new(:id => 1, :name => 'do stuff1'), Todo::Task.new(:id => 2, :name => 'do stuff2')]
            @todo.done(2)
            proc { @todo.gc }.must_output "[ ]\t1\t\tdo stuff1\n"
        end
    end

end
