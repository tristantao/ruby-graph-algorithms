require_relative 'node'
require_relative 'graph'
require_relative 'breath_first_search'
require 'CSV'
require 'byebug'

vertex_hash = {}

graph = Graph.new

START_NODE = '1'
END_NODE = '155'

START_NODE_2 = '1'
END_NODE_2 = '1234'

START_NODE_3 = '2222'
END_NODE_3 = '22222'

START_NODE_4 = '1'#'0'
END_NODE_4 = '0'#'403392'


CSV.foreach("data/amazon_small.txt", {:col_sep => "\t"}) do |row|
    e_1 = vertex_hash.fetch(row[0], Node.new(row[0]))
    e_2 = vertex_hash.fetch(row[1], Node.new(row[1]))

    !vertex_hash.key? row[0] ? vertex_hash[row[0]] = e_1 : nil

    !vertex_hash.key? row[1] ? vertex_hash[row[1]] = e_2 : nil

    graph.add_edge(e_1, e_2)

    row[0] == START_NODE ? @start_node = e_1 : nil
    row[1] == END_NODE ? @end_node = e_2 : nil

    row[0] == START_NODE_2 ? @start_node2 = e_1 : nil
    row[1] == END_NODE_2 ? @end_node2 = e_2 : nil

    row[0] == START_NODE_3 ? @start_node3 = e_1 : nil
    row[1] == END_NODE_3 ? @end_node3 = e_2 : nil
   
    row[0] == START_NODE_4 ? @start_node4 = e_1 : nil
    row[1] == END_NODE_4 ? @end_node4 = e_2 : nil
end

path1 = BreathFirstSearch.new(graph, @start_node).shortest_path_to(@end_node)
CSV.open("result.csv", "ab") do |csv|
  csv << [@start_node.name, @end_node.name, path1.size]
end

path2 = BreathFirstSearch.new(graph, @start_node2).shortest_path_to(@end_node2)
CSV.open("result.csv", "ab") do |csv|
  csv << [@start_node2.name, @end_node2.name, path2.size]
end

path3 = BreathFirstSearch.new(graph, @start_node3).shortest_path_to(@end_node3)
CSV.open("result.csv", "ab") do |csv|
  csv << [@start_node3.name, @end_node3.name, path3.size]
end

path4 = BreathFirstSearch.new(graph, @start_node4).shortest_path_to(@end_node4)
CSV.open("result.csv", "ab") do |csv|
  csv << [@start_node4.name, @end_node4.name, path4.size]
end

puts path1.size
