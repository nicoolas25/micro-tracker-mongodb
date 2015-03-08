require 'mongo'

module Utracker
  module MongoDB
    class Logger < Utracker::Logger
      attr_reader :client
      attr_reader :database

      def initialize(database_name: "utracker")
        @client = Mongo::MongoClient.new
        @database = @client[database_name]
      end

      protected

      def write(event)
        event_collection << {
          datetime: event.datetime,
          service: event.service,
          description: event.description,
          uuid: event.message.uuid,
          parent_uuid: event.message.parent_uuid,
          payload: event.payload,
        }
      end

      def event_collection
        database['entries']
      end

    end
  end
end
