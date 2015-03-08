RSpec.describe Utracker::MongoDB::Drawer do
  let(:instance) { described_class.new(database_name: database_name,
                                       collection_name: collection_name) }

  let(:database_name) { "utracker_test" }
  let(:collection_name) { "entries" }

  before { instance.database.drop_collection(collection_name) }

  describe "#build_graph" do
    subject { instance.__send__(:build_graph) }
    it { is_expected.to eq [] }

    context "after writing event via the logger" do
      let(:logger) { Utracker::MongoDB::Logger.new(database_name: database_name,
                                                   collection_name: collection_name) }

      let(:graph) do
        node1 = Utracker::Drawer::Node.new("node1", [])
        node2 = Utracker::Drawer::Node.new("node2", nil)
        node1.edges << node1
        [node1, node2]
      end

      before do
        node1_event = {
          datetime: Time.now,
          service: "node1",
          description: "sending",
          message: double(parent_uuid: nil, uuid: '1'),
          payload: "payload",
          options: {},
        }
        node2_event = node1_event.merge({
          datetime: Time.now,
          service: "node2",
          description: "receiving",
        })
        logger.__send__(:write, double("Event", node1_event))
        logger.__send__(:write, double("Event", node2_event))
      end

      it { is_expected.to eq graph }
    end
  end
end
