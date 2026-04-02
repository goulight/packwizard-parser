# frozen_string_literal: true

require 'httparty'
require 'json'

module PackwizardParser

  # Parser for extracting data from PackWizard JSON
  #
  # Parser fetches data from the PackWizard API by shareable ID or URL
  # Accepts full URL or just the ID. In case of full URL insert, we extract the ID and add it to the API_URL.
  # Delegate parsing to ListParser, CategoryParser, and ItemParser
  class Parser

    API_URL = "https://www.packwizard.com/api/packs/getSharedPackWithId"
    def initialize(shareable_id:)

      @shareable_id = extract_id(shareable_id)


      @item_parser = ItemParser.new
      @category_parser = CategoryParser.new
      @list_parser = ListParser.new
    end

    def parse
      response = HTTParty.get(API_URL, query: { sharableId: @shareable_id }, timeout: 30)
      raise "Failed to fetch #{response.code}" unless response.success?

      data = JSON.parse(response.body)
      @list_parser.parse(data, category_parser: @category_parser, item_parser: @item_parser)
    end

    private

    def extract_id(input)
      # If the user only inserts the id of the list
      return input unless input.include?("/")
      # If the user inserts the full url
      input.split("/").last
    end

  end
end
