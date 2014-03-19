require "spec_helper"

describe BuildLogParser do
  before do
    [:tests, :coverage, :duration].each do |method_name|
      BuildLogParser::Parser.any_instance.stub(method_name)
    end
  end

  describe ".tests" do
    it "returns tests metrics" do
      expect_any_instance_of(BuildLogParser::Parser).to receive(:tests)
      described_class.tests("foo")
    end
  end

  describe ".coverage" do
    it "returns coverage metrics" do
      expect_any_instance_of(BuildLogParser::Parser).to receive(:coverage)
      described_class.coverage("foo")
    end
  end

  describe ".duration" do
    it "returns duration metrics" do
      expect_any_instance_of(BuildLogParser::Parser).to receive(:duration)
      described_class.duration("foo")
    end
  end
end 