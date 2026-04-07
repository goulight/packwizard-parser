# frozen_string_literal: true

module PackwizardParser
  class Item
    attr_reader :name, :description, :weight, :total_weight, :quantity, :price, :total_price, :image_url,
                :consumable, :total_consumable_weight, :worn, :worn_quantity, :total_worn_weight

    def initialize(name:, weight:, total_weight:, quantity:, description: nil,
                   image_url: nil, consumable: false, total_consumable_weight: nil,
                   worn: false, worn_quantity: nil, total_worn_weight: nil)
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
