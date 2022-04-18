class PolyTreeNode
  attr_reader :parent, :children, :value

  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def parent=(parent)
    return if @parent == parent
    
    if @parent != nil
      @parent.children.delete(self)
    end
    # reassign
    @parent = parent
    
    # add child
    if @parent != nil 
      parent.children << self
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "Node is not a child of #{self}" if child_node.parent == nil
    child_node.parent = nil
  end

  def dfs(target)
    return self if target == self.value
    # p self
    self.children.each do |child|
      found = child.dfs(target)
      return found if found
    end
    nil
  end

  def bfs(target)
    queue = [self]

    until queue.empty?
      node = queue.shift
      if node.value == target
        return node
      else
        node.children.each do |child|
          queue << child
        end
      end
    end
    nil
  end


end