# frozen_string_literal: true

RSpec.describe PackwizardParser::Parser do
  let(:fixture_json) { File.read(File.join(__dir__, 'fixtures', 'tUE6BJs.json')) }
  let(:fake_response) do
    instance_double(HTTParty::Response, success?: true, body: fixture_json, code: 200)
  end

  before do
    allow(HTTParty).to receive(:get).and_return(fake_response)
  end

  describe "#parse" do
    subject(:list) { described_class.new(shareable_id: 'tUE6BJs').parse }

    it 'returns a List object' do
      expect(list).to be_a(PackwizardParser::List)
    end

    it 'extracts the list name' do
      expect(list.name).to eq('Ultralight Gear List 2023')
    end

    it 'extracts the list description' do
      expect(list.description).to end_with('but this pack comes close!')
    end

    it 'accepts a full URL and extracts the ID' do
      parser = described_class.new(shareable_id: 'https://www.packwizard.com/s/tUE6BJs')
      parser.parse
      expect(HTTParty).to have_received(:get).with(
        PackwizardParser::Parser::API_URL,
        hash_including(query: { shareableId: 'tUE6BJs' }),
      )
    end

    it 'calls the API with the correct shareable ID' do
      list
      expect(HTTParty).to have_received(:get).with(
        PackwizardParser::Parser::API_URL,
        hash_including(query: { shareableId: 'tUE6BJs' })
      )
    end

    it 'raises a failed response' do
      allow(HTTParty).to receive(:get).and_return(
        instance_double(HTTParty::Response, success?: false, code: 404),
      )
      expect { described_class.new(shareable_id: "bad").parse }.to raise_error(RuntimeError, /404/)
    end
  end
end
