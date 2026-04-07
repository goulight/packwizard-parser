# frozen_string_literal: true

module PackwizardParser
  # Parser for extracting PackWizard list data from JSON.
  class ListParser
    # Extract the lists name and description.
    # Extract the categories and their items
    #
    # @param data [Hash] The fully parsed JSON response.
    # @param category_parser [CategoryParser] Parser for extracting the categories
    # @param item_parser [ItemParser] Parser for extracting the items
    # @return [List] The parsed list
    def parse(data, category_parser:, item_parser:)
      List.new(
        name: extract_name(data),
        description: extract_description(data),
        categories: category_parser.parse_all(data, item_parser: item_parser)
      )
    end

    private

    def extract_name(data)
      name = data['packName']
      return name unless name.nil? || name.empty?

      'Untitled list' # fallback if name is not set
    end

    def extract_description(data)
      description = data['packDescription']
      return description unless description.nil? || description.empty?

      nil
    end
  end
end
