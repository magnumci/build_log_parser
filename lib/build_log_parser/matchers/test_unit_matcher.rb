module BuildLogParser
  module TestUnitMatcher
    TEST_UNIT_PATTERN = /^([\d]+) (tests|runs), ([\d]+) assertions, ([\d]+) failures, ?([\d]+) errors(, ([\d]+) skips)?$/m

    def fetch_test_unit_stats(str)
      if str =~ TEST_UNIT_PATTERN
        {
          count:    $1.to_i,
          failures: $4.to_i,
          pending:  $7 ? $7.to_i : nil
        }
      end
    end
  end
end