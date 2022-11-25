def find(key, node = @root)
  puts "The key # node.data} exists in node # node}" if node.data == key
  return node if node.nil? || node.data == key

  if node.data < key
    find(key, node.right)
  elsif node.data > key
    find(key, node.left)
  end
 node
end
