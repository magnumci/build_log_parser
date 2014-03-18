require "spec_helper"

describe BuildLogParser::Parser do
  let(:parser) { described_class.new(log) }

  describe "#tests" do
    let(:result) { parser.tests }

    context "when no test data" do
      let(:log) { "foobar" }

      it "returns nil" do
        expect(result).to be_nil
      end
    end

    context "on test unit data" do
      let(:log) { fixture "test_unit.txt" }

      it "returns a hash" do
        expect(result).to be_a Hash
      end

      it "includes number of tests" do
        expect(result[:count]).to eq 11
      end

      it "includes number of failed tests" do
        expect(result[:failures]).to eq 4
      end

      it "includes number pending tests" do
        expect(result[:pending]).to eq nil
      end
    end

    context "on rspec data" do
      let(:log) { fixture "rspec.txt" }

      it "returns a hash" do
        expect(result).to be_a Hash
      end

      it "includes number of specs" do
        expect(result[:count]).to eq 71
      end

      it "includes number of failed specs" do
        expect(result[:failures]).to eq 0
      end

      it "includes number of pending specs" do
        expect(result[:pending]).to eq 2
      end
    end

    context "on multiple rspec data" do
      let(:log) { fixture "rspec_multiple.txt" }

      it "returns a hash" do
        expect(result).to be_a Hash
      end

      it "includes sum of specs" do
        expect(result[:count]).to eq 1686
      end

      it "includes sum of failures" do
        expect(result[:failures]).to eq 15
      end

      it "includes sum of pending" do
        expect(result[:pending]).to eq 3
      end
    end
  end

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
      expect(result[:lines_covered]).to eq 3354
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

  describe "#duration" do
    let(:result) { parser.duration }

    context "with no duration data" do
      let(:log) { "no duration entries here..." }

      it "returns nil" do
        expect(result).to be_nil
      end
    end

    context "with duration entry" do
      let(:formats) do
        [
          ["Finished in 5 seconds", 5.00],
          ["Ran 1234 tests in 14.855s", 14.855],
          ["Time: 01:50, Memory: 113.00Mb", 110.00],
          ["Finished tests in 8.071688s, 3.8406 tests/s, 9.4156 assertions/s.", 11.912288]
        ]
      end

      it "parses multiple formats" do
        formats.each do |f|
          expect(described_class.new(f[0]).duration).to eq f[1]
        end
      end
    end

    context "with multiple duration entries" do
      let(:log) { fixture "rspec_multiple_duration.txt" }

      it "returns total duration" do
        expect(result).to eq 942.0924699999999
      end
    end
  end
end