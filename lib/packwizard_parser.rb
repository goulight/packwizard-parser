# frozen_string_literal: true

require_relative 'packwizard_parser/version'
require_relative 'packwizard_parser/gram_converter'
require_relative 'packwizard_parser/item'
require_relative 'packwizard_parser/category'
require_relative 'packwizard_parser/list'
require_relative 'packwizard_parser/item_parser'
require_relative 'packwizard_parser/category_parser'
require_relative 'packwizard_parser/list_parser'
require_relative 'packwizard_parser/parser'

# Parser for extracting data from PackWizard list
#
# Provides classes and methods to parse PackWizard list JSON and extract
# structured data including list information, categories, and items with their
# properties (weight, quantity, consumable status, etc.).
module PackwizardParser

  # Convenience method to parse a PackWizard URL
  def self.parse_url(shareable_id)
    Parser.new(shareable_id: shareable_id).parse
  end
end
