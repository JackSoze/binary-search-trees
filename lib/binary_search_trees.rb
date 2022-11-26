# this builds the induvidual nodes
class Node
  include Comparable
  attr_accessor :data, :right, :left

  def initialize(data)
    @data = data
    @left = @right = nil
  end

  def <=>(other)
    data <=> other.data
  end
end

# this builds instances of trees
class Tree
  attr_accessor :root, :arr

  def initialize(array)
    @array = array.sort.uniq
    @root = build_tree(array)
    @arr = []
  end

  def build_tree(array)
    return nil if array.empty?

    mid = array.length / 2
    node = Node.new(array[mid])
    node.left = build_tree(array[0...mid])
    node.right = build_tree(array[mid + 1..])
    node
  end

  def return_new_arr
    # creating new_array to return an array while resetting @arr = []
    new_arr = arr
    self.arr = []
    p new_arr
    new_arr
  end

  def pre_order(node = @root)
    return if node.nil?

    if block_given?
      yield node
      pre_order(node.left) { |node| puts node.data }
      pre_order(node.right) { |node| puts node.data }
    else
      @arr << node.data
      pre_order(node.left)
      pre_order(node.right)
    end
    return_new_arr if !block_given? && node == @root
  end

  def in_order(node = @root)
    return if node.nil?

    if block_given?
      in_order(node.left) { |node| puts node.data }
      yield node
      in_order(node.right) { |node| puts node.data }
    else
      in_order(node.left)
      arr << node.data
      in_order(node.right)
    end
    return_new_arr if !block_given? && node == @root # return_new_arr here if missbehave
  end

  def post_order(node = @root)
    return if node.nil?

    if block_given?
      post_order(node.right) { |node| puts node.data }
      post_order(node.left) { |node| puts node.data }
      yield node
    else
      post_order(node.right)
      post_order(node.left)
      arr << node.data
    end
    return_new_arr if !block_given? && node == @root
  end

  def find(key, node = @root)
    puts "The key #{node.data} exists in node #{node}" if node.data == key
    return node if node.nil? || node.data == key

    puts @root.data
    if node.data < key
      find(key, node.right)
    elsif node.data > key
      find(key, node.left)
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

  def min_value_node(node)
    current = node

    current = current.left until current.left.nil?

    current
  end

  def delete(key, root = @root)
    return root if root.nil?

    if key > root.data
      root.right = delete(key, root.right)
    elsif key < root.data
      root.left = delete(key, root.left)
    else
      # node with one child only or no child
      if root.left.nil?
        temp = root.right
        root = nil
        return temp
      elsif root.right.nil?
        temp = root.left
        root = nil
        return temp
      end
      # node with two children
      temp = min_value_node(root.right)
      root.data = temp.data
      root.right = delete(temp.data, root.right)
    end
    root
  end

  def level_order(root = @root)
    return if root.nil?

    level_order_array = []
    queue = []
    queue.push(root)
    until queue.empty?
      current = queue[0]
      if block_given?
        yield current
      else
        level_order_array << current.data
      end
      queue.push(current.left) unless current.left.nil?
      queue.push(current.right) unless current.right.nil?
      queue.shift
    end
    puts level_order_array unless block_given?
  end

  # doesnt take arguments and when used outside class...
  # ...it gives the total depth only
  def node_height(root = @root)
    if root.nil?
      0
    else
      nleft = node_height(root.left)
      nright = node_height(root.right)
      lambda = -> { nleft > nright ? (nleft + 1) : (nright + 1) }
      lambda.call
    end
  end

  def find_depth(root = @root, key)
    return -1 if root.nil?

    dist = -1
    if (root.data == key) ||
       (dist = find_depth(root.left, key)) >= 0 ||
       (dist = find_depth(root.right, key)) >= 0
      return dist + 1
    end

    dist
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def balanced?(root = @root)
    return true if root.nil?

    lh = node_height(root.left)

    rh = node_height(root.right)

    if ((lh - rh).abs <= 1) && balanced?(root.left) == true && balanced?(root.right) == true
      puts true
      return true
    end

    puts false
    false
  end

  def height(key)
    found_node = find(key)
    this_node_height = node_height(found_node)
    puts "the node (#{found_node.data}:#{found_node}) found and its height is #{this_node_height}"
    this_node_height
  end

  def rebalance
    sorted_arr = self.in_order
    self.root = build_tree(sorted_arr)
  end
end

array = [1, 2, 3, 4, 5, 6, 7]

new_tree = Tree.new(array)

new_tree.pretty_print

new_tree.post_order
