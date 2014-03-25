require "build_log_parser/matchers/duration_matcher"
require "build_log_parser/matchers/coverage_matcher"
require "build_log_parser/matchers/rspec_matcher"
require "build_log_parser/matchers/test_unit_matcher"
require "build_log_parser/matchers/phpunit_matcher"

module BuildLogParser
  class Parser
    include DurationMatcher
    include CoverageMatcher
    include RspecMatcher
    include TestUnitMatcher
    include PHPUnitMatcher

    attr_reader :body

    def initialize(body)
      @body = body
    end

    def duration
      fetch_duration(body)
    end

    def tests
      fetch_rspec_stats(body) ||
      fetch_test_unit_stats(body) ||
      fetch_phpunit_stats(body)
    end

    def coverage
      fetch_coverage(body)
    end    
  end
end