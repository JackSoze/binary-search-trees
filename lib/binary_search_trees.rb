# this builds the induvidual nodes
class Node
attr_accessor :data, :right, :left
  def initialize(data)
    @data = data
    @left = @right = nil
  end
end

# this builds instances of trees
class Tree
attr_accessor :root
  def initialize(array)
    @array = array
    @root = build_tree(array)
  end

  def build_tree(array)
    return nil if array.empty?
    mid = (array.length)/2
    node = Node.new(array[mid])
    node.left = build_tree(array[0...mid])
    node.right = build_tree(array[mid + 1..-1])
    node
  end

  def pre_order(node = @root)
    return if node == nil
    puts node.data
    pre_order(node.left)
    pre_order(node.right)
  end
end

array = [1,2,3,4,5,6,7,8]

new_tree = Tree.new(array)
new_tree.build_tree(array)
new_tree.pre_order

