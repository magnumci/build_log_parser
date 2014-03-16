require "spec_helper"

describe BuildLogParser::Parser do
  let(:parser) { described_class.new(log) }

  describe "#coverage" do
    let(:log)    { "Coverage report generated for RSpec to /tmp/coverage. 3354 / 5045 LOC (66.48%) covered." }
    let(:result) { parser.coverage }

    it "returns a hash" do
      expect(result).to be_a Hash
    end

    it "includes coverage percentage" do
      expect(result[:coverage_percent]).to eq 66.48
    end

    it "includes number of lines" do
      expect(result[:lines]).to eq 3354
    end

    it "includes total number of lines" do
      expect(result[:lines_total]).to eq 5045
    end

    context "with no coverage data" do
      let(:log) { "Foobar" }

      it "returns nil" do
        expect(result).to be_nil
      end
    end
  end
end