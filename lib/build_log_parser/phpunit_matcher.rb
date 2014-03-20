module BuildLogParser
  module PHPUnitMatcher
    PHPUNIT_PATTERN = /^(OK|FAIL) \(([\d]+) tests/

    def fetch_phpunit_stats(str)
      if str =~ PHPUNIT_PATTERN
        {
          count: $2.to_i,
          failures: nil,
          pending: nil
        }
      end
    end
  end
end