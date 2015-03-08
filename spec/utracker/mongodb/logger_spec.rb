RSpec.describe Utracker::MongoDB::Logger do
  let(:instance) { described_class.new(database_name: database_name,
                                       collection_name: collection_name) }

  let(:database_name) { "utracker_test" }
  let(:collection_name) { "entries" }
  let(:collection) { instance.database[collection_name] }

  before { instance.database.drop_collection(collection_name) }

  describe "#client" do
    subject { instance.client }
    it { is_expected.to be_a Mongo::MongoClient }
  end

  describe "#database" do
    subject { instance.database }
    it { is_expected.to be_a Mongo::DB }

    describe "the name of the database" do
      subject { instance.database.name }
      it { is_expected.to eq database_name }
    end
  end

  describe "#write" do
    subject { instance.__send__(:write, event) }

    let(:datetime) { Time.now }
    let(:event) do
      double({
        datetime: datetime,
        service: "service_name",
        description: "event_name",
        message: double(parent_uuid: '1', uuid: '2'),
        payload: "payload",
        options: {},
      })
    end

    it "writes an entry into the collection" do
      expect { subject }.to change { collection.count }.by(1)
    end

    describe "the entry written in the collection" do
      let(:entry) { collection.find.next }
      before { instance.__send__(:write, event) }

      describe "the datetime field" do
        subject { entry['datetime'] }
        it { is_expected.to be_within(0.001).of(datetime) }
      end

      describe "the service field" do
        subject { entry['service'] }
        it { is_expected.to eq 'service_name' }
      end

      describe "the description field" do
        subject { entry['description'] }
        it { is_expected.to eq 'event_name' }
      end

      describe "the uuid field" do
        subject { entry['uuid'] }
        it { is_expected.to eq '2' }
      end

      describe "the parent_uuid field" do
        subject { entry['parent_uuid'] }
        it { is_expected.to eq '1' }
      end

      describe "the payload field" do
        subject { entry['payload'] }
        it { is_expected.to eq 'payload' }
      end
    end
  end
end
