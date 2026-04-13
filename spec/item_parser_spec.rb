# frozen_string_literal: true

RSpec.describe PackwizardParser::ItemParser do
  let(:fixture_json) { File.read(File.join(__dir__, 'fixtures', 'tUE6BJs.json')) }
  let(:data) { JSON.parse(fixture_json) }
  let(:parser) { described_class.new }

  describe '#parse' do
    context 'with Plex Solo Tent row. Category: Big 3' do
      let(:category) { data['tableData'].find { |c| c['title'] == 'Big 3' } }
      let(:rows) { category['rows'] }
      let(:row) { rows['row_lhkykmnb'] }

      it 'extracts the item name' do
        item = parser.parse(row)
        expect(item.name).to eq('Plex Solo Tent')
      end

      it 'extracts the item weight' do
        item = parser.parse(row)
        expect(item.weight).to eq(394)
      end

      it 'extracts the item quantity' do
        item = parser.parse(row)
        expect(item.quantity).to eq(1)
      end

      it 'extracts the imageUrl' do
        item = parser.parse(row)
        expect(item.image_url).to eq('https://zpacks.com/cdn/shop/files/plexsoloclassic_2048x.jpg?v=1713272032')
      end

      it 'extracts the description' do
        item = parser.parse(row)
        expect(item.description).to include('The lightest of the light')
        expect(item.description).to end_with('back and side sleepers alike.')
      end

      it 'extracts the consumable flag: False' do
        item = parser.parse(row)
        expect(item.consumable).to be(false)
      end

      it 'extracts the worn flag: False' do
        item = parser.parse(row)
        expect(item.worn).to be(false)
      end

      it 'extracts the total_weight' do
        item = parser.parse(row)
        expect(item.total_weight).to eq(394)
      end

      it 'extracts the total_quantity' do
        item = parser.parse(row)
        expect(item.quantity).to eq(1)
      end

      it 'extracts the total_consumable_weight' do
        item = parser.parse(row)
        expect(item.total_consumable_weight).to eq(nil)
      end

      it 'extracts the total_worn_weight' do
        item = parser.parse(row)
        expect(item.total_worn_weight).to eq(0)
      end
    end

    # These testcases should check if the weight conversion of ounces to grams works
    # Also if the consumable flag works

    context 'with Snackbars row. Category: Cook System' do
      let(:category) { data['tableData'].find { |c| c['title'] == 'Cook System' } }
      let(:rows) { category['rows'] }
      let(:row) { rows['row_mnfyxjad'] }

      it 'extracts consumable flag: True' do
        item = parser.parse(row)
        expect(item.consumable).to be(true)
      end

      it 'extracts the item weight and converts oz to grams' do
        # item weight in oz = 1, should equal 28.35 grams
        item = parser.parse(row)
        expect(item.weight).to be_within(0.01).of(28.35)
      end

      it 'extracts the item_total_weight and converts oz to grams' do
        # item weight in oz = 1, quantity 4, should equal total_weight of 113.4 grams
        item = parser.parse(row)
        expect(item.total_weight).to be_within(0.01).of(113.4)
      end

      it 'extracts the total_consumable_weight and converts oz to grams' do
        # item weight in oz = 1, quantity 4, should equal total_consumable_weight of 113.4 grams
        item = parser.parse(row)
        expect(item.total_consumable_weight).to be_within(0.01).of(113.4)
      end
    end

    describe 'with Socks row. Category: Clothing' do
      let(:category) { data['tableData'].find { |c| c['title'] == 'Clothing' } }
      let(:rows) { category['rows'] }
      let(:row) { rows['row_lhqtz6q5'] }

      it 'extracts quantity' do
        item = parser.parse(row)
        expect(item.quantity).to eq(3)
      end

      it 'extracts weight and converts lb to grams' do
        # item weight in lb 0.08, should equal to 36.29 grams
        item = parser.parse(row)
        expect(item.weight).to be_within(0.01).of(36.29)
      end

      it 'extracts the item_total_weight and converts lb to grams' do
        # Quantity of 3, should equal to 108.87 grams
        item = parser.parse(row)
        expect(item.total_weight).to be_within(0.01).of(108.87)
      end

      it 'extracts the worn flag: True' do
        item = parser.parse(row)
        expect(item.worn).to be(true)
      end

      it 'extracts the worn_quantity, should be 1 regardless of quantity' do
        item = parser.parse(row)
        expect(item.worn_quantity).to eq(1)
      end

      it 'extracts the total_worn_weight and converts lb to grams' do
        item = parser.parse(row)
        expect(item.total_worn_weight).to be_within(0.01).of(36.29)
      end
    end

    describe 'with Decathlon Fleece pants row. Category: Clothing' do
      let(:category) { data['tableData'].find { |c| c['title'] == 'Clothing' } }
      let(:rows) { category['rows'] }
      let(:row) { rows['row_ljhklzt7'] }

      it 'extracts the weight and converts kg to grams' do
        item = parser.parse(row)
        expect(item.weight).to be_within(0.01).of(149)
      end
    end

    describe 'negative testcases with negative.json' do
      let(:fixture_json) { File.read(File.join(__dir__, 'fixtures', 'negative.json')) }
      let(:data) { JSON.parse(fixture_json) }
      let(:parser) { described_class.new }
      let(:category) { data['tableData'].first }
      let(:rows) { category['rows'] }
      let(:row) { rows['row_negative'] }

      it 'negative weight should return 0.0' do
        item = parser.parse(row)
        expect(item.weight).to eq(0.0)
      end

      it 'negative quantity should return 1' do
        item = parser.parse(row)
        expect(item.quantity).to eq(1)
      end

      it 'unknown unit type (xyz) should return 0.0' do
        item = parser.parse(row)
        expect(item.weight).to eq(0.0)
      end

      it 'empty name should return Untitled item' do
        item = parser.parse(row)
        expect(item.name).to eq('Untitled item')
      end

      it 'empty description should return nil' do
        item = parser.parse(row)
        expect(item.description).to be_nil
      end

      it 'empty url should return nil' do
        item = parser.parse(row)
        expect(item.image_url).to be_nil
      end
    end
  end
end
