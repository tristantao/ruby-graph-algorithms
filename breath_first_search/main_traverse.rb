require_relative 'node'
require_relative 'graph'
require_relative 'breath_first_search'
require 'CSV'
require 'byebug'

vertex_hash = {}

graph = Graph.new

START_NODE = '1'
END_NODE = '155'

CSV.foreach("data/amazon0601.txt", {:col_sep => "\t"}) do |row|
    e_1 = vertex_hash.fetch(row[0], Node.new(row[0]))
    e_2 = vertex_hash.fetch(row[1], Node.new(row[1]))

    !vertex_hash.key? row[0] ? vertex_hash[row[0]] = e_1 : nil

    !vertex_hash.key? row[1] ? vertex_hash[row[1]] = e_2 : nil

    graph.add_edge(e_1, e_2)

    row[0] == START_NODE ? @start_node = e_1 : nil
    row[1] == END_NODE ? @end_node = e_2 : nil
end

byebug

path = BreathFirstSearch.new(graph, @start_node).shortest_path_to(@end_node)

puts path.size
