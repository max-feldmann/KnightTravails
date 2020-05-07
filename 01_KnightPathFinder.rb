require_relative "00_tree_node"

class KnightPathFinder

    VALID_MOVES = [[-2,1], [-2,-1], [-1,-2], [1,-2],
                    [2,-1], [2,1], [-1,2], [1,2]]
                    #=> add all those to a position in form of [x,y] to get possible moves of the knight

    attr_reader :current_position, :root_node, :starting_position

    def initialize(starting_position)
        @current_position = starting_position
        @considered_moves = [starting_position] #=> Initialized w/ starting pos.

        build_move_tree
    end

    def valid_moves(pos) #=> Returns 2D-Array of valid Moves e.g. [[3,3], ...]
        potentials = []

        VALID_MOVES.each do |move| # go through predefined moves and add them to the position.
            possible_move = [0,0]
            possible_move[0] = pos[0] + move[0]
            possible_move[1] = pos[1] + move[1]

            unless possible_move.any? {|val| val > 7} # Make sure move is on the chess board (8x8)
                potentials << possible_move
            end

        end

        potentials
    end

    def new_move_positions(pos) #=> Returns 2D-Array of possible next moves, without such that have already been considered
        new_moves = []
        potential_moves = valid_moves(pos)
        
        #> Get potential moves, go through them
        #> If they have not yet been considered, add them to new_moves and add to "considered"

        potential_moves.each do |move| 
            if !@considered_moves.include?(move)
                new_moves << move 
                @considered_moves << move
            end
        end
        new_moves
    end

    def build_move_tree

        root_node = PolyTreeNode.new(starting_position) #> Set Root-Node of Polytree to Starting-Position

        nodes = [root_node]

        until nodes.empty?
            current_node = nodes.shift
            current_position = current_node.value

            new_move_positions(current_position).each do |next_position|
                next_node = PolyTreeNode.new(next_position)
                current_node.add_child(next_node)
                nodes << next_node
            end
        end
    end

    def find_path(destination) #=> Return 2D-Array of Positions that leads to Destination
        end_node = root_node.dfs(destination)

        path = trace_back_path(end_node) #> Returns path-array
        path.map(&:value)

        return path
    end

    def trace_back_path(end_node)
        path = []

        current_node = end_node

        until current_node.nil?
            path << current_node
            current_node = current_node.parent
        end

        return path.reverse
    end
end



kpf = KnightPathFinder.new([0, 0])
p kpf.find_path([7, 7])