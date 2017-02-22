class Node
	attr_accessor :value, :parent, :children
	def initialize(value)
		@value=value
		@parent=nil
		@children=[]
	end
end