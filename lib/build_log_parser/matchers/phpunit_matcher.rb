module BuildLogParser
  module PHPUnitMatcher
    PHPUNIT_PATTERN = /^(OK|FAIL) \(([\d]+) tests/
    PHPUNIT_PATTERN_ERROR =  /Tests: ([\d]+), Assertions: [\d]+, Errors: ([\d]+)/

    def fetch_phpunit_stats(str)
      if str =~ PHPUNIT_PATTERN
        {
          count: $2.to_i,
          failures: nil,
          pending: nil
        }
      elsif str =~ PHPUNIT_PATTERN_ERROR
        {
          count: $1.to_i,
          failures: $2.to_i,
          pending: nil
        }
      end
    end
  end
end