# frozen_string_literal: true

module PackwizardParser
  # Parser for extracting category data from PackWizard JSON
  class CategoryParser
    # Parse all categories from a PackWizard JSON
    #
    # @param data [Hash] The parsed JSON response
    # @param item_parser [ItemParser] The parser used for extracting items from each category
    # @return [Array<Category>] Array of extracted categories
    def parse_all(data, item_parser:)
      categories = []

      # tableData contains the arrays of each category
      data['tableData'].each do |category_data|
        category = parse(category_data, item_parser: item_parser)
        categories << category if category
      end
      categories
    end

    private

    # Parse a single category row
    #
    # @param category_data [Hash] A single entry from data['tableData']
    def parse(category_data, item_parser:)
      name = extract_name(category_data)

      description = extract_description(category_data)

      items = extract_items(category_data, item_parser: item_parser)

      Category.new(name: name, description: description, items: items)
    end

    def extract_name(category_data)
      name = category_data['title']
      return name unless name.nil? || name.empty?

      'Untitled category' # Fallback if name is not set
    end

    def extract_description(category_data)
      description = category_data['subtitle']
      return description unless description.nil? || description.empty?

      nil
    end

    def extract_items(category_data, item_parser:)
      rows = category_data['rows']
      return [] unless rows

      rows.values.map do |row|
        item_parser.parse(row)
      end
    end
  end
end
