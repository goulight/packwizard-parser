# frozen_string_literal: true

RSpec.describe PackwizardParser::CategoryParser do
  let(:fixture_json) { File.read(File.join(__dir__, 'fixtures', 'tUE6BJs.json')) }
  let(:data) { JSON.parse(fixture_json) }
  let(:parser) { described_class.new }
  let(:item_parser) { PackwizardParser::ItemParser.new }

  describe '#parse_all' do
    let(:list) { parser.parse_all(data, item_parser: item_parser) }

    it 'extracts the first category' do
      first_category = list.first
      expect(first_category.description).to eq('Pack, Tent, Sleep System')
      expect(first_category.name).to eq('Big 3')
      expect(first_category.items).to be_a(Array)
      expect(first_category.items.length).to be > 0
    end
  end

  describe 'negative testcases' do
    let(:fixture_json) { File.read(File.join(__dir__, 'fixtures', 'negative.json')) }
    let(:data) { JSON.parse(fixture_json) }
    let(:parser) { described_class.new }
    let(:item_parser) { PackwizardParser::ItemParser.new }
    let(:list) { parser.parse_all(data, item_parser: item_parser) }

    it 'extract empty category name' do
      first_category = list.first
      expect(first_category.name).to eq('Untitled category')
    end

    it 'extract empty description' do
      first_category = list.first
      expect(first_category.description).to be_nil
    end
  end
end
