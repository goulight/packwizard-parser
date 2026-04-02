# frozen_string_literal: true


module PackwizardParser

  class List
    attr_reader :name, :description, :categories

    def initialize(name:, description: nil, categories: [])
      @name = name
      @description = description
      @categories = categories
      end

    def to_h
      {
        name: name,
        description: description,
        categories: categories.map(&:to_h)
      }
    end

  end
end
