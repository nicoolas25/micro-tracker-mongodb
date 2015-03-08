require 'mongo'

class Utracker::MongoDB::Drawer < Utracker::Drawer
  attr_reader :database

  def initialize(database_name: "utracker", collection_name: "entries")
    @client = Mongo::MongoClient.new
    @database = @client[database_name]
    @collection_name = collection_name
  end

  protected

  def build_graph
    nodes.values.each do |node|
      node.edges = edges_for(node)
    end
  end

  private

  def nodes
    @nodes ||= service_names.each_with_object({}) do |service_name, directory|
      directory[service_name] = Utracker::Drawer::Node.new(service_name, nil)
    end
  end

  def service_names
    collection.distinct('service')
  end

  def edges_for(node)
    aggregate = edges.find { |agg| agg["_id"]["service"] == node.service }
    aggregate && aggregate["edges"].map{ |service_name| nodes[service_name] }
  end

  def edges
    @edges ||= edge_collection.aggregate([
      { "$unwind" => "$value.handled_by" },
      { "$group" => {
          "_id" => { "service" => "$value.authored_by" },
          "edges" => { "$addToSet" => "$value.handled_by" },
        },
      },
    ])
  end

  def edge_collection
    @edge_collection ||= collection.map_reduce(
      EDGE_MAP_FN,
      EDGE_REDUCE_FN,
      out: { replace: "#{@collection_name}_drawer" }
    )
  end

  def collection
    @collection ||= database[@collection_name]
  end

  EDGE_MAP_FN = <<-MAP
function() {
  var value = { authored_by: this.service, handled_by: [], handled_at: {} };
  value.handled_at[this.service] = this.datetime;
  var key = this.uuid;
  emit(key, value);
}
  MAP

  EDGE_REDUCE_FN = <<-REDUCE
function(key, values) {
  var handled_at = {};
  var handled_by = [];
  var first_handled = new Date();
  var first_handler;

  values.forEach(function(value) {
    var author = value.authored_by;
    var datetime = value.handled_at[author];

    if (datetime < first_handled) {
      first_handler = author;
      first_handled = datetime;
    }

    if (!(author in handled_at) || datetime < handled_at[author]) {
      handled_at[author] = datetime;
    }
  });

  for(var service in handled_at) {
    if (service !== first_handler) {
      handled_by.push(service);
    }
  }

  return {
    authored_by: first_handler,
    handled_by: handled_by,
    handled_at: handled_at
  };
}
  REDUCE

end
