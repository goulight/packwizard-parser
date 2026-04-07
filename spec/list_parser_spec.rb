# frozen_string_literal: true

RSpec.describe PackwizardParser::ListParser do
  let(:fixture_json) { File.read(File.join(__dir__, 'fixtures', 'tUE6BJs.json')) }
  let(:data) { JSON.parse(fixture_json) }
  let(:parser) { described_class.new }
  let(:item_parser) { PackwizardParser::ItemParser.new }
  let(:category_parser) { PackwizardParser::CategoryParser.new }

  describe '#parse' do
    let(:list) { parser.parse(data, category_parser: category_parser, item_parser: item_parser) }

    it 'extracts list name' do
      expect(list.name).to eq('Ultralight Gear List 2023')
    end

    it 'extracts the lists description' do
      expect(list.description).to end_with('but this pack comes close!')
    end

    it 'returns an array of Category objects' do
      expect(list.categories).to be_a(Array)
      expect(list.categories.length).to be > 0
    end

    it 'returns an array of Item objects' do
      first_category = list.categories.first
      expect(first_category.items).to be_a(Array)
      expect(first_category.items.length).to be > 0
    end
  end

  describe '#negative cases with negative.json' do
    let(:fixture_json) { File.read(File.join(__dir__, 'fixtures', 'negative.json')) }
    let(:data) { JSON.parse(fixture_json) }
    let(:parser) { described_class.new }
    let(:item_parser) { PackwizardParser::ItemParser.new }
    let(:category_parser) { PackwizardParser::CategoryParser.new }

    let(:list) { parser.parse(data, category_parser: category_parser, item_parser: item_parser) }

    it 'extract empty list name' do
      expect(list.name).to eq('Untitled list')
    end

    it 'extract empty description' do
      expect(list.description).to be_nil
    end
  end
end
