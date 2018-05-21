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
    def initialize(val)
        @head = Node.new(val)
    end
    def append(val)
        if head.nil?
            @head = Node.new(val)
            return
        end
        node = head
        last = nil
        while(node)
            last = node
            node = node.next
        end
        last.next = Node.new(val)
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
            head = node.next
            node = nil
            return
        end
        last = node
        node = node.next
        while(node)
            if node.val == val
                last.next = node.next
                node = nil
                return
            end
            last = node
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


    end
end

l = LinkedList.new(1)
l.append(2)
l.append(3)
l.append(4)
l.append(5)

l.print
l.delete(2)
l.print


