# frozen_string_literal: true

require "benchmark"

RSpec.describe "PackWizard URL benchmark", :benchmark do
  let(:url) { "https://www.packwizard.com/s/sqRHbz2" }

  it "measures parsing the shared list through the gem" do
    list = nil

    elapsed = Benchmark.realtime do
      list = PackwizardParser.parse_url(url)
    end

    milliseconds = elapsed * 1000

    RSpec.configuration.reporter.message(
      format("PackwizardParser.parse_url(%<url>s) took %<ms>.0fms", url: url, ms: milliseconds)
    )

    expect(list).to be_a(PackwizardParser::List)
    expect(list.categories).not_to be_empty
  end
end
