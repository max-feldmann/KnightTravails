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