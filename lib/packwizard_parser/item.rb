# frozen_string_literal: true

module PackwizardParser
  # Represents a single item in a PackWizard list
  #
  # @attr_reader [String] name The name of the item
  # @attr_reader [String, nil] description Optional description of the item
  # @attr_reader [Float] weight Weight per item in grams
  # @attr_reader [Float] total_weight Total weight (weight * quantity) in grams
  # @attr_reader [Integer] quantity Number of items
  # @attr_reader [String, nil] image_url Optional URL to item image
  # @attr_reader [Boolean] consumable Whether the item is consumable
  # @attr_reader [Float, nil] total_consumable_weight Total consumable weight
  #   (weight * quantity) if consumable, nil otherwise
  # @attr_reader [Boolean] worn Whether the item is worn
  # @attr_reader [Integer] worn_quantity Number of worn items (always 1 if worn, 0 otherwise)
  # @attr_reader [Float] total_worn_weight Total worn weight (weight * 1) if worn, 0.0 otherwise
  class Item
    attr_reader :name, :description, :weight, :total_weight, :quantity, :price, :total_price, :image_url,
                :consumable, :total_consumable_weight, :worn, :worn_quantity, :total_worn_weight
    # @param name [String] The name of the item
    # @param description [String, nil] Optional description
    # @param weight [Float] Weight per item in grams
    # @param total_weight [Float] Total weight (weight * quantity) in grams
    # @param quantity [Integer] Number of items
    # @param image_url [String, nil] Optional URL to item image
    # @param consumable [Boolean] Whether the item is consumable
    # @param total_consumable_weight [Float, nil] Total consumable weight if consumable
    # @param worn [Boolean] Whether the item is worn
    # @param worn_quantity [Integer] Number of worn items (1 if worn)
    # @param total_worn_weight [Float] Total worn weight if worn
    def initialize(name:, weight:, total_weight:, quantity:, description: nil,
                   image_url: nil, consumable: false, total_consumable_weight: nil,
                   worn: false, worn_quantity:, total_worn_weight:)
      @name = name
      @weight = weight
      @description = description
      @total_weight = total_weight
      @quantity = quantity
      @image_url = image_url
      @consumable = consumable
      @total_consumable_weight = total_consumable_weight
      @worn = worn
      @worn_quantity = worn_quantity
      @total_worn_weight = total_worn_weight
    end

    alias worn? worn

    alias consumable? consumable

    # Convert to hash
    #
    # @return [Hash] Hash representation of the item
    def to_h
      {
        name: name,
        description: description,
        weight: weight,
        total_weight: total_weight,
        quantity: quantity,
        image_url: image_url,
        consumable: consumable,
        total_consumable_weight: total_consumable_weight,
        worn: worn,
        worn_quantity: worn_quantity,
        total_worn_weight: total_worn_weight
      }
    end
  end
end
