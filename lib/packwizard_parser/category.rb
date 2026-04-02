# frozen_string_literal: true


module PackwizardParser

  class Category
    attr_reader :name, :description, :items

    def initialize(name:, description: nil, items: [])
      @name = name
      @description = description
      @items = items
    end

    def to_h
      {
        name: name,
        description: description,
        items: items.map(&:to_h)
      }
    end

  end
end

