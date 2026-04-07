# frozen_string_literal: true

module PackwizardParser
  class ItemParser
    # Parser for extracting a single item row from PackWizard JSON
    #
    # @param row [Hash] A single row hash from category['rows']
    # @return [Item] The parsed item
    def parse(row)
      name = extract_name(row)
      description = extract_description(row)

      weight_per_item = extract_weight(row)
      quantity = extract_quantity(row)

      image_url = extract_image_url(row)

      consumable = extract_consumable_flag(row)
      total_consumable_weight = consumable ? weight_per_item * quantity : nil

      # In PackWizard, the returned worn weight is a single items weight regardless of quantity
      worn = extract_worn_flag(row)
      worn_quantity = worn ? 1 : 0
      total_worn_weight = weight_per_item * worn_quantity

      total_weight = weight_per_item * quantity

      Item.new(
        name: name,
        description: description,
        weight: weight_per_item,
        total_weight: total_weight,
        quantity: quantity,
        image_url: image_url,
        consumable: consumable,
        total_consumable_weight: total_consumable_weight,
        worn: worn,
        worn_quantity: worn_quantity,
        total_worn_weight: total_worn_weight
      )
    end

    private

    def extract_name(row)
      item_name = row['item']
      return item_name unless item_name.nil? || item_name.empty?

      'Untitled item'
    end

    def extract_weight(row)
      # Extract unit and weight from JSON
      # If there is a negative value, cancel early and set it to 0.0
      value = row['weight'].to_f
      return 0.0 if value <= 0

      unit = row['unit'].to_s.downcase

      # Use module GramConverter to convert the value to grams
      converted_weight = GramConverter.convert(value: value, unit: unit)
      return converted_weight if converted_weight

      0.0 # Default value as a fallback
    end

    def extract_quantity(row)
      quantity = row['quantity'].to_i
      quantity if quantity >= 0
    end

    def extract_worn_flag(row)
      # weightType 1 for worn items
      row['weightType'] == 1
    end

    def extract_consumable_flag(row)
      # weightType 2 for consumables
      row['weightType'] == 2
    end

    def extract_description(row)
      description = row['description']
      return description unless description.nil? || description.empty?

      nil
    end

    def extract_image_url(row)
      image_url = row['imageUrl']
      return image_url unless image_url.nil? || image_url.empty?

      nil
    end
  end
end
