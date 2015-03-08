require 'mongo'

class Utracker::MongoDB::Logger < Utracker::Logger
  attr_reader :client, :database, :collection_name

  def initialize(database_name: "utracker", collection_name: "entries")
    @client = Mongo::MongoClient.new
    @database = @client[database_name]
    @collection_name = collection_name
  end

  protected

  def write(event)
    collection << {
      datetime: event.datetime,
      service: event.service,
      description: event.description,
      uuid: event.message.uuid,
      parent_uuid: event.message.parent_uuid,
      payload: event.payload,
    }
  end

  def collection
    @collection ||= database[@collection_name]
  end

end
