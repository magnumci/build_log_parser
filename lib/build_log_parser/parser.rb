require "build_log_parser/duration_matcher"
require "build_log_parser/coverage_matcher"
require "build_log_parser/test_matcher"

module BuildLogParser
  class Parser
    include DurationMatcher
    include CoverageMatcher
    include TestMatcher

    attr_reader :body

    def initialize(body)
      @body = body
    end

    def duration
      fetch_duration(body)
    end

    def tests
      fetch_rspec_stats(body) ||
      fetch_test_unit_stats(body)
    end

    def coverage
      fetch_coverage(body)
    end    
  end
end