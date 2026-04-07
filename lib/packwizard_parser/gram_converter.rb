# frozen_string_literal: true

module PackwizardParser
  # Created a module instead of a class so we don't need to instantiate an object
  module GramConverter
    # Conversion factors for each unit to grams
    FACTORS = {
      'g' => 1.0,
      'kg' => 1000.0,
      'oz' => 28.35,
      'lb' => 453.59
    }.freeze

    # Convert the value to grams
    #
    # @param value [Float] The value to convert
    # @param unit [String] The unit extracted from the JSON
    # @return [Float] The converted value in grams
    def self.convert(value:, unit:)
      factor = FACTORS.fetch(unit.to_s.downcase, 1.0)
      (value * factor)
    end
  end
end
