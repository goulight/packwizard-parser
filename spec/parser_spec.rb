# frozen_string_literal: true

RSpec.describe PackwizardParser::Parser do
  let(:fixture_json) {File.read(File.join(__dir__, 'fixtures', 'tUE6BJs.json'))}
  let(:data) { JSON.parse(fixture_json) }
  let(:rows) { data['tableData'].first['rows'] }
  #let(:parser) { described_class.new}

  # TODO
  # Integration tests for parser.rb

end