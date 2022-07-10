class Node
    attr_accessor :val
    attr_accessor :next_node

    def initialize(val = 0, next_node = nil)
        @val = val
        @next_node = next_node
    end
end

class LinkedList
    
    attr_accessor :list
    
    def initialize(list)
        @list = list
    end

    # add new node at the end of the list
    def append(value)
        tail = @list
        until tail.next_node == nil do
            tail = tail.next_node
        end 
        tail.next_node = Node.new(value) 
    end

    # add new node at the beginning of the list
    def prepend(value)
        head = @list
        @list = Node.new(value, head) 
    end

    # get the size of the list
    def size
        list = @list
        count = 0
        until list == nil do
            count += 1
            list = list.next_node
        end
        count
    end 

    # return the first node in the list
    def head
        @list
    end

    # return the last node in the list
    def tail
        tail = @list
    until tail.next_node == nil do tail = tail.next_node end 
        tail 
    end

    # return the node at specific index
    def at(index)
        node = @list
        index.times { node = node.next_node }
        node 
    end

    # remove the last node from the list
    def pop
        list = @list
        until list.next_node.next_node == nil do list = list.next_node end
        list.next_node = nil
    end

    # make sure that a value is in the list
    def contain?(value)
        list = @list
        until list == nil do 
            if list.val == value
                return true
            end
            list = list.next_node 
        end
        false
    end

    # find the index for given node value
    def find(value)
        list = @list
        index = 0
        until list == nil do
            if list.val == value
                return index
            end
            index += 1
            list = list.next_node
        end
        "value not found"
    end

    # print the list
    def to_s
        list = @list
        until list.next_node == nil do
            print "#{list.val} -> "
            list = list.next_node
        end  
        puts "#{list.val} -> nil"
    end

    def insert_at(value, index)
        list = @list
        
        if index > size()
            return "index bigger than the size of the list"
        end
        
        until list == nil do
            if index - 1 == 0
                list.next_node = Node.new(value, list.next_node)
                break
            end 
            index -= 1
            list = list.next_node
        end 
    end

    def remove_at(index)
        list = @list
        
        if index > size()
            return "index bigger than the size of the list"
        end
        
        until list == nil do
            if index - 1 == 0
                list.next_node = list.next_node.next_node
                break
            end 
            index -= 1
            list = list.next_node
        end 
    end
end


def array_to_list(arr)
    list = Node.new()
    head = list
    for i in 0..arr.length-1 do
        head.val = arr[i]
        if i != arr.length - 1
            head.next_node = Node.new()
            head = head.next_node
        end
    end
    list
end

# testing section
arr = [1, 2 ,4]

list = array_to_list(arr)
linked_list = LinkedList.new(list)

print "My List: "
linked_list.to_s()
puts "------------------"
linked_list.append(3)
print "Add to the end of the list: "
linked_list.to_s()
puts "------------------"
linked_list.prepend(5)
print "Add to the beginning of the list: "
linked_list.to_s()
puts "------------------"
print "List's size: "
puts linked_list.size()
puts "------------------"
print "First node in the list: "
p linked_list.head()
puts "------------------"
print "Last node in the list: "
p linked_list.tail()
puts "------------------"
print "Get node at 2 postion: "
p linked_list.at(2)
puts "------------------"
linked_list.pop()
print "pop method(remove the node at the end): "
linked_list.to_s()
puts "------------------"
print "is 2 in the list?: "
p linked_list.contain?(2)
puts "------------------"
print "is 8 in the list?: "
p linked_list.contain?(8)
puts "------------------"
print "The index for the node with value = 5: "
p linked_list.find(5)
puts "------------------"
print "The index for the node with value = 8: "
p linked_list.find(8)
puts "------------------"
print "Test to_s method(convert the list into string): "
linked_list.to_s()
puts "------------------"
print "Insart 9 at 1 postion in the list: "
linked_list.insert_at(9, 1)
linked_list.to_s
puts "------------------"
print "Remove the node at 3 postion in the list: "
linked_list.remove_at(3)
linked_list.to_s