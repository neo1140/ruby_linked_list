# Class for the list, contains data about list size, and methods for modifying the list
class LinkedList
  attr_reader :head, :tail, :size

  def initialize(data)
    @size = 0
    @head = Node.new(data, @size)
    @tail = @head
    @size += 1
  end

  def append(data)
    if size.zero?
      @head = Node.new(data, @size)
      @tail = @head
    else
      @tail.next_node = Node.new(data, @size)
      @tail = @tail.next_node
    end
    @size += 1
  end

  def prepend(data)
    new_head = Node.new(data, 0, @head)
    index_update(@head, 1) unless @head.nil?
    @head = new_head
    @tail = @head if @size.zero?
    @size += 1
  end

  def index_update(node, index)
    node.index = index
    index_update(node.next_node, (index + 1)) unless node.next_node.nil?
  end

  def at(index)
    node_search(@head, index)
  end

  def pop
    removed_node = @tail
    @size -= 1 unless @size.zero?
    @tail = node_search(@head, (@size - 1)) unless @tail.nil?
    @tail.next_node = nil unless @tail.nil?
    @head = nil if @size.zero?
    removed_node
  end

  def node_search(node, target)
    if node.index == target
      node
    elsif !node.next_node.nil?
      node_search(node.next_node, target)
    else
      nil
    end
  end

  def contains?(value)
    node = @head
    until node.nil?
      return true if node.data == value
      node = node.next_node
    end
    false
  end

  def find(value)
    node = @head
    until node.nil?
      return node.index if node.data == value
      node = node.next_node
    end
    nil
  end

  def insert_at(value, index)
    shifted_node = node_search(@head, index)
    new_node = Node.new(value, index, shifted_node)
    previous_node = node_search(@head, (index - 1))
    previous_node.next_node = new_node
  end

  def remove_at(index)
    removed_node = node_search(@head, index)
    previous_node = node_search(@head, (index - 1))
    previous_node.next_node = removed_node.next_node
    removed_node.data
  end

  def to_s
    string = ''
    node = @head
    until node.nil?
      string += "( #{node.data} ) => "
      node = node.next_node
    end
    string += 'nil'
    string
  end
end

# Node class contains individual node data, and a pointer to the next node
class Node
  attr_accessor :data, :next_node, :index

  def initialize(data = nil, index = nil, next_node = nil)
    @data = data
    @index = index
    @next_node = next_node
  end
end
