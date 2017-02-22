require_relative './tree'
require_relative './node'

class Knight
	#Returns an array with all the possible, legal moves the knight can make given an inital position.
	def possible_moves(array)
		return nil if array.size!=2
		x = array[0]
		y = array[1]
		moves = [-2,-1,1,2].permutation(2).to_a.select {|i| i[0].abs!=i[1].abs}
		possible_moves = moves.select {|i| (x+i[0]).between?(0,7)&&(y+i[1]).between?(0,7)}
		possible_positions = []
		possible_moves.each {|i| possible_positions << [x+i[0],y+i[1]]}
		return possible_positions
	end

	#Builds the tree given starting position and stops once the node with our target position is built.
	def find_target(root, target)
		tree = Tree.new
		tree.root = Node.new(root)
		que = [tree.root]
		until que[0].value==target
			possible_moves(que[0].value).each do |move|
				new_node = Node.new(move)
				que[0].children << move
				new_node.parent = que[0]
				que << new_node
			end
			que.shift
		end
		return que[0] #Returns the node at the position we want the knight to move to, which has the parent data we are looking for.
	end
	#Returns the chain of parents leading to the target.
	def parents(target)
		ancestors = [target]
		current_ancestor = target
		moves = []
		until current_ancestor==nil
			current_ancestor = current_ancestor.parent
			ancestors << current_ancestor unless current_ancestor.nil?
		end
		ancestors.each {|node| moves << node.value}
		return moves.reverse
	end
	#Tying methods together
	def optimal_move(root, target)
		node = find_target(root, target)
		parents = parents(node)
		puts "You made it in #{parents.size-1} moves!"
		puts "Here is your path:"
		parents.each {|parent| puts "#{parent}"}
	end
end

knight = Knight.new

knight.optimal_move([3,3],[3,3])





