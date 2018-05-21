require 'byebug'
class Node
    attr_accessor :val,:next
    def initialize(val)
        @val = val
        @next = nil
    end
end

class LinkedList
    attr_accessor :head
    def initialize(val=nil)
        @head = val.nil? ?  nil : Node.new(val)
    end
    def append(val)
        if head.nil?
            @head = Node.new(val)
            return
        end
        node = head
        while(node.next)
            node = node.next
        end
        node.next = Node.new(val)
    end

    def prepend(val)
        if head.nil?
            @head = Node.new(val)
            return
        end
        node = Node.new(val)
        node.next = head
        @head = node
    end

    def delete(val)
        return if head.nil?
        node = head
        if node.val == val
            @head = node.next
            node = nil
            return
        end
        while(node.next)
            if node.next.val == val
                node.next = node.next.next
                return
            end
            node = node.next
        end
    end

    def print
        values = []
        node = head
        while(node)
            values << node.val
            node = node.next
        end
        puts values.join(',')
    end

    def self.merge(l1, l2)
        current = nil
        head = nil
        l3 = new
        node1 = l1.head
        node2 = l2.head
        while(node1 && node2)
            if (node1.val < node2.val)
                next_node = node1
                node1 = node1.next
            else
                next_node = node2
                node2 = node2.next
            end

            if current.nil?
                current = next_node
                head = current
            else
                current.next = next_node
                current = next_node
            end

        end
        current.next = node1.nil? ? node2 : node1
        l3.head = head
        l3
    end
end

l1 = LinkedList.new(2)
l1.append(2)
l1.append(4)
l1.append(6)
l1.append(8)

l1.print

l2 = LinkedList.new(1)
l2.append(3)
l2.append(5)
l2.append(7)
l2.append(7)

l2.print


l3 = LinkedList.merge(l1,l2)
l3.print

l3.delete(1)
l3.print