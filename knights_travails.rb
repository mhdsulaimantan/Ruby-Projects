class Move
    
    @@visited = []
    
    attr_accessor :cell
    attr_accessor :parent

    def initialize(cell, parent)
        @cell = cell
        @parent = parent
        @@visited.push(cell)
    end
    
    # finding all the move that the knight can take in specific node
    def all_posible_moves(node)
        row = node[0]
        col = node[1]
        moves = Array.new()
        # move: 2-up/1-right
        moves.push(Move.new([row + 2, col + 1], self)) if (row + 2 < 8 && col + 1 < 8) && !@@visited.include?([row + 2, col + 1])
        # move: 2-up/1-left
        moves.push(Move.new([row + 2, col - 1], self)) if (row + 2 < 8 && col - 1 > 0) && !@@visited.include?([row + 2, col - 1])
        # move: 1-up/2-right
        moves.push(Move.new([row + 1, col + 2], self)) if (row + 1 < 8 && col + 2 < 8) && !@@visited.include?([row + 1, col + 2])
        # move: 1-up/2-left
        moves.push(Move.new([row + 1, col - 2], self)) if (row + 1 < 8 && col - 2 > 0) && !@@visited.include?([row + 1, col - 2])
        # move: 2-down/1-right
        moves.push(Move.new([row - 2, col + 1], self)) if (row - 2 > 0 && col + 1 < 8) && !@@visited.include?([row - 2, col + 1])
        # move: 2-down/1-left
        moves.push(Move.new([row - 2, col - 1], self)) if (row - 2 > 0 && col - 1 > 0) && !@@visited.include?([row - 2, col - 1])
        # move: 1-down/2-right
        moves.push(Move.new([row - 1, col + 2], self)) if (row - 1 > 0 && col + 2 < 8) && !@@visited.include?([row - 1, col + 2])
        # move: 1-down/2-left
        moves.push(Move.new([row - 1, col - 2], self)) if (row - 1 > 0 && col - 2 > 0) && !@@visited.include?([row - 1, col - 2])
        
        moves
    end
end

    def knight_moves(start_point, end_point)
        queue = []
        node = Move.new(start_point, nil)
        until node.cell == end_point do
            node.all_posible_moves(node.cell).each { |move| queue.push(move) }
            node = queue.shift
        end
        
        return node
    end

    # testing
    puts "Choosing the start and end point randomly..."
    start_point = [rand(0..7), rand(0..7)]
    end_point = [rand(0..7), rand(0..7)]
    puts "knight will start at #{start_point} and go to #{end_point}."
    path_nodes = knight_moves(start_point, end_point)
    path = []
    until path_nodes.nil?
        path.push(path_nodes.cell)
        path_nodes = path_nodes.parent
    end
    puts "knight can reach its destination with #{path.length-1} moves: "
    path.reverse.each { |cell| p cell}

