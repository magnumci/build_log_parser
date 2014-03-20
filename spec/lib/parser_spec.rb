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

      it "returns test metrics" do
        expect(result).to eq Hash(
          count: 11,
          failures: 4,
          pending: nil
        )
      end

      context "on alternative syntax" do
        let(:log) { fixture "test_unit_2.txt" }

        it "returns tests metrics" do
          expect(result).to eq Hash(
            count: 3971,
            failures: 11,
            pending: 1
          )
        end
      end
    end

    context "on rspec data" do
      let(:log) { fixture "rspec.txt" }

      it "returns rspec test metrics" do
        expect(result).to eq Hash(
          count: 71,
          failures: 0,
          pending: 2
        )
      end
    end

    context "on rspec with multiple runs" do
      let(:log) { fixture "rspec_multiple.txt" }

      it "returns summarized test metrics" do
        expect(result).to eq Hash(
          count: 1686,
          failures: 15,
          pending: 3
        )
      end
    end

    context "with phpunit data" do
      let(:log) { fixture "phpunit.txt" }

      it "returns test metrics" do
        expect(result).to eq Hash(
          count: 5,
          failures: nil,
          pending: nil
        )
      end
    end
  end

  describe "#coverage" do
    let(:log)    { "Coverage report generated for RSpec to /tmp/coverage. 3354 / 5045 LOC (66.48%) covered." }
    let(:result) { parser.coverage }

    it "returns a hash" do
      expect(result).to be_a Hash
    end

    it "returns coverage metrics hash" do
      expect(result).to eq Hash(
        coverage_percent: 66.48,
        lines_covered: 3354,
        lines_total: 5045
      )
    end

    context "with no coverage data" do
      let(:log) { "Foobar" }

      it "returns nil" do
        expect(result).to be_nil
      end
    end

    context "with phpunit data" do
      let(:log) { fixture "phpunit.txt" }

      it "returns coverage metrics" do
        expect(result).to eq Hash(
          coverage_percent: 81.16,
          lines_covered: 1034,
          lines_total: 1274
        )
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
          [ "Finished in 5 seconds", 5.00 ],
          [ "Ran 1234 tests in 14.855s", 14.855 ],
          [ "Time: 01:50, Memory: 113.00Mb", 110.00 ],
          [ "Finished tests in 8.071688s, 3.8406 tests/s, 9.4156 assertions/s.", 8.071688 ],
          [ "Finished in 10.8 seconds (3.1s on load, 7.7s on tests)", 10.8 ],
          [ "80 passing (347ms)", 0.347 ]
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

    context "with phpunit data" do
      let(:log) { fixture "phpunit.txt" }

      it "returns total duration" do
        expect(result).to eq 0.176
      end
    end
  end
end