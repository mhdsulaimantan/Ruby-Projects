module Comparable
    # make sure that the node is not in the tree
    def contains?(tree)

        until tree == nil do
            if @val == tree.val
                return true
            elsif @val > tree.val
                tree = tree.right
            else
                tree = tree.left
            end
        end 
        return false
    end
end


class Node

    attr_accessor :val
    attr_accessor :left
    attr_accessor :right
    
    include Comparable

    def initialize(val = 0, left = nil, right = nil)
        @val = val
        @left = left
        @right = right
    end

end

class Tree

    attr_accessor :root

    def initialize(array)
        # array should be unique and sorted
        @root = build_tree(array.uniq.sort)
    end

    # build a balanced binary tree
    def build_tree(arr)

        return nil if arr.empty?

        middle = (arr.length - 1) / 2
        node = Node.new(arr[middle])
    
        node.left = build_tree(arr[0...middle])
        node.right = build_tree(arr[(middle + 1)..-1])
    
        node
    end

    # insert new node to the tree
    def insert(value, tree = @root)
        # first make sure that the node is not in the tree
        new_node = Node.new(value)
        unless new_node.contains?(tree)
            while 1 do
                if tree.val < new_node.val
                    if tree.right.nil?
                        tree.right = new_node
                        return "The node inserted successfully"
                    end
                    tree = tree.right 
                else
                    if tree.left.nil?
                        tree.left = new_node
                        break
                    end
                    tree = tree.left
                end
            end
        end
        return "This node is already exist!!!"
    end

    # delete a node with specific value from the tree 
    def delete(value, tree = @root)
        pre_node = nil
        until tree == nil do
            if tree.val == value
                if tree.right
                    tree.val = tree.right.val
                    tree.right = tree.right.right
                    
                elsif tree.left
                    tree.val = tree.left.val
                    tree.left = tree.left.left
                else
                    # deleting the leaf node
                    pre_node.left = nil
                    pre_node.right = nil
                end

                return "The node deleted successfully"
            
            elsif tree.val > value
                pre_node = tree
                tree = tree.left
            else
                pre_node = tree
                tree = tree.right
            end
        end

        return "There is no node with this value!!!"
    end

    # return the node that have specific value
    def find(value)
        tree = @root
        until tree == nil do
            if value == tree.val
                return tree
            
            elsif value > tree.val
                tree = tree.right
            else
                tree = tree.left
            end
        end
        return "The node not found!!!"
    end

    # return array of all tree values (BFS algorithm)
    def level_order(tree = @root, bfs_arr = [], queue = [])

        if tree == nil
            return bfs_arr
        else
            bfs_arr.push(tree.val)
            
            if tree.left
                queue.unshift(tree.left)
            end
            if tree.right
                queue.unshift(tree.right)
            end
        
            return level_order(queue.last, bfs_arr, queue[..-2])
        end
    end

    # return array of tree values (DFS inorder algorithm)
    def in_order(tree = @root, dfs_arr = [])

        if tree.left 
            in_order(tree.left, dfs_arr)
        end

        dfs_arr.push(tree.val)
        
        if tree.right
            in_order(tree.right, dfs_arr)
        end

        return dfs_arr
    end

    # return array of tree values (DFS postorder algorithm)
    def post_order(tree = @root, dfs_arr = [])

        if tree.left 
            post_order(tree.left, dfs_arr)
        end
        
        if tree.right
            post_order(tree.right, dfs_arr)
        end

        dfs_arr.push(tree.val)
        
        return dfs_arr
    end

    # return array of tree values (DFS inorder algorithm)
    def pre_order(tree = @root, dfs_arr = [])

        dfs_arr.push(tree.val)

        if tree.left 
            pre_order(tree.left, dfs_arr)
        end
        
        if tree.right
            pre_order(tree.right, dfs_arr)
        end
        
        return dfs_arr
    end

    # find the height for a node (the longest path to the last leaf)
    def height(node, left = 0, right = 0)
    
        return [left, right] if node.nil?

        if node.left
            left = 1 + height(node.left, left, right)[0]
        end

        if node.right
            right = 1 + height(node.right, left, right)[1]
        end

        return [left, right]
    end

    # find the depth of a node from the root node
    def depth(node, tree = @root, level = 0)
        return level if node == tree

        if tree.left
            right = depth(node, tree.left, level + 1)
        end

        if tree.right
            left = depth(node, tree.right, level + 1)
        end
        
        return right if right
        return left if left

    end

    def balanced?(node = @root)
        return true if node.nil?

        height = height(node)
        return true if (height[0] - height[1]).abs <= 1 && balanced?(node.left) && balanced?(node.right)
    
        false
      end

      # balance the tree
      def rebalance
        data = in_order()
        @root = build_tree(data)
      end

      # print the tree
      def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.val}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
      end
end


# Testing

tree = Tree.new((Array.new(15) { rand(1..100) }))

if tree.balanced?
    puts "The tree is balanced"
else
    puts "The tree is not balanced"
end

tree.pretty_print()
puts "----------------"

puts "The BFS array: "
p tree.level_order()
puts "----------------"

puts "The DFS inorder array: "
p tree.in_order()
puts "----------------"

puts "The DFS postorder array:"
p tree.post_order()
puts "----------------"

puts "The DFS preorder array:"
p tree.pre_order()
puts "----------------"

puts "Adding different nodes to the tree: "
5.times do 
    tree.insert(rand(101..200))
end
tree.pretty_print()
puts "----------------"

unless tree.balanced?
    puts "The tree is not balanced, rebalancing the tree..."
    tree.rebalance()
    tree.pretty_print()
else
    puts "The tree is already balanced"
end
puts "----------------"

puts "Enter a number or value to delete from the tree: "
p tree.delete(gets.chomp.to_i)
tree.pretty_print()
puts "----------------"

puts "Enter a node value that you want to find: "
p tree.find(gets.chomp.to_i)
puts "----------------"

puts "Enter a node to calculate its height and depth: "
node = tree.find(gets.chomp.to_i)

# make sure that the node in the tree
if node.instance_of?(String)
    puts node
else 
    puts "height: "
    p tree.height(node).max
    puts "depth: "
    p tree.depth(node)
end
puts "----------------"

