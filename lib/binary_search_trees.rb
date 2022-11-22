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

    mid = array.length / 2
    node = Node.new(array[mid])
    node.left = build_tree(array[0...mid])
    node.right = build_tree(array[mid + 1..])
    node
  end

  def pre_order(node = @root)
    return if node.nil?

    puts node.data
    pre_order(node.left)
    pre_order(node.right)
  end

  def find(key, root = @root)
    return if root.nil?

    puts "The key #{root.data} exists in node #{root}" if root.data == key
    if root.data < key
      find(key, root.right)
    elsif root.data > key
      find(key, root.left)
    end
  end

  def insert(key, root = @root)
    if root.nil?
      root = Node.new(key)
      return root
    end
    return if key == root.data

    root.right = insert(key, root.right) if key > root.data

    root.left = insert(key, root.left) if key < root.data

    root
  end
end

array = [2, 3, 4]

new_tree = Tree.new(array)

new_tree.build_tree(array)
new_tree.insert(5)
new_tree.insert(1)
new_tree.insert(0)
new_tree.pre_order
# puts new_tree.find(67)
