# PackWizard Parser

A Ruby gem for parsing PackWizard lists from URLs.

Used by [Goulight](https://goulight.com). Source: [github.com/goulight/packwizard-parser](https://github.com/goulight/packwizard-parser).

## Installation

Add to your `Gemfile`:

```ruby
gem 'packwizard-parser'
```

Then:

```bash
bundle install
```

Or install directly:

```bash
gem install packwizard-parser
```

The gem is published on [RubyGems](https://rubygems.org/gems/packwizard-parser).

## Usage

`PackwizardParser::Parser#parse` (and `PackwizardParser.parse_url`) return a **`PackwizardParser::List`** object with readers `name`, `description`, and `categories`. Each category is a **`PackwizardParser::Category`**; each item is a **`PackwizardParser::Item`**.

Call **`#to_h`** on the list (or on categories/items) if you need nested hashes (for example JSON APIs).

### Parse from URL or ID

```ruby
require 'packwizard_parser'

# With full URL
list = PackwizardParser::Parser.new(shareable_id: 'https://www.packwizard.com/s/Dv5388R').parse

# With ID
list = PackwizardParser::Parser.new(shareable_id: 'Dv5388R').parse

# Or using the convenience method
list = PackwizardParser.parse_url('https://www.packwizard.com/s/Dv5388R')
list = PackwizardParser.parse_url('Dv5388R')

list.name                    # => "List Name"
list.description             # => "List description" or nil
list.categories.first.name   # => "Category Name"

item = list.categories.first.items.first
item.name                    # => "Item Name"
item.description             # => "Item description" or nil
item.weight                  # => 476.0   # grams per unit
item.total_weight            # => 476.0   # weight * quantity (grams)
item.quantity                # => 1
item.image_url               # => "https://..." or nil
item.consumable              # => false
item.total_consumable_weight # => nil (or total grams if consumable)
item.worn                    # => false
item.worn_quantity           # => 0 (or 1 if worn)
item.total_worn_weight       # => 0.0 (or grams worn, weight × 1)

# Hash shape (matches nested #to_h):
list.to_h
# => {
#   name: "List Name",
#   description: nil,
#   categories: [
#     {
#       name: "Category Name",
#       description: nil,
#       items: [
#         {
#           name: "Item Name",
#           description: "Item description",
#           weight: 476.0,
#           total_weight: 476.0,
#           quantity: 1,
#           image_url: "https://...",
#           consumable: false,
#           total_consumable_weight: nil,
#           worn: false,
#           worn_quantity: 0,
#           total_worn_weight: 0.0
#         }
#       ]
#     }
#   ]
# }
```

## Running Tests

To run the test suite:

```bash
rspec
```

To run the PackWizard URL benchmark spec:

```bash
RUN_BENCHMARKS=1 bundle exec rspec spec/packwizard_url_benchmark_spec.rb
```

The benchmark uses `https://www.packwizard.com/s/sqRHbz2` and reports how long
`PackwizardParser.parse_url` takes through the gem.

## Test Fixtures

Test fixtures are stored in `spec/fixtures/` and contain JSON from example PackWizard lists:

- `negative.json` - This data with negative / empty values
- `tUE6BJs.json` - A copy from Ultralight Gear List 2023 (Dv5388R)

To update fixtures, download fresh JSON:

```bash
curl -s 'https://www.packwizard.com/api/packs/getSharedPackWithId?shareableId=Dv5388R' > spec/fixtures/Dv5388R.json
```

## Features

- Parses list name and description
- Extracts categories with descriptions
- Extracts items with:
    - Name and description
    - Weight per unit and total weight (automatically converted to grams)
    - Quantity
    - Image URLs
    - Consumable flag and total consumable weight when applicable
    - Worn flag, worn quantity, and total worn weight when applicable
- Supports weight units: oz, lb, g, kg (all converted to grams)
- Handles URL's

## Weight Conversion

The parser automatically converts all weights to grams:

- `oz` → multiply by 28.3495
- `lb` → multiply by 453.592
- `g` → use as-is
- `kg` → multiply by 1000

## Development

To install dependencies locally:

```bash
bundle install
```
