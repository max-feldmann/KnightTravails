module Searchable
    # I wrote this as a mixin in case I wanted to later write another
    # TreeNode class (e.g., BinaryTreeNode). All I need is `#children` and
    # `#value` for `Searchable` to work.
  
    def dfs(target = nil, &prc)
      raise "Need a proc or target" if [target, prc].none?
      prc ||= Proc.new { |node| node.value == target }
  
      return self if prc.call(self)
  
      children.each do |child|
        result = child.dfs(&prc)
        return result unless result.nil?
      end
  
      nil
    end
  
    def bfs(target = nil, &prc)
      raise "Need a proc or target" if [target, prc].none?
      prc ||= Proc.new { |node| node.value == target }
  
      nodes = [self]
      until nodes.empty?
        node = nodes.shift
  
        return node if prc.call(node)
        nodes.concat(node.children)
      end
  
      nil
    end
  
    def count
      1 + children.map(&:count).inject(:+)
    end
  end

class PolyTreeNode

    attr_reader :value, :parent, :children

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(node) # Sets the parent of self
        # parent = shall set or reassign the new parent of self

        # if self is equal to new node, it shall not set new node as parent
        return if self.parent == node

        # If we have a parent already, method shall detach node from parent
        # This means self deletes itself from the old parent´s array of children
        if self.parent
            self.parent.children.delete(self)
        end

        # set node as new parent
        @parent = node

        # self adds itself to the new parent´s (node´s) array of childen
        # it does so only, if its parent is not nil (aka if it has a parent)
        self.parent.children << self unless self.parent.nil?
    end

    def add_child(child_node)
        child_node.parent = self
    end

    def remove_child(child)
        if child && !self.children.include?(child)
            raise "Tried to remove child that does not exist!"
        end

        child.parent = nil
    end

end