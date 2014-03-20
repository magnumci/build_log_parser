module BuildLogParser
  module TestMatcher
    PATTERN_RSPEC     = /^([\d]+) examples, ([\d]+) failures(, ([\d]+) pending)?/m
    PATTERN_TEST_UNIT = /^([\d]+) (tests|runs), ([\d]+) assertions, ([\d]+) failures, ?([\d]+) errors(, ([\d]+) skips)?$/m

    def fetch_rspec_stats(str)
      matches = str.scan(PATTERN_RSPEC)
      return if matches.empty?

      result = { count: 0, failures: 0, pending: 0 }

      matches.each do |m|
        result[:count]    += m[0].to_i if m[0] # examples
        result[:failures] += m[1].to_i if m[1] # failures
        result[:pending]  += m[3].to_i if m[3] # pending
      end

      result
    end

    def fetch_test_unit_stats(str)
      if str =~ PATTERN_TEST_UNIT
        {
          count:    $1.to_i,
          failures: $4.to_i,
          pending:  $7 ? $7.to_i : nil
        }
      end
    end
  end
end