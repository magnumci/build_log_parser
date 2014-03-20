module BuildLogParser
  module RspecMatcher
    RSPEC_PATTERN = /^([\d]+) examples, ([\d]+) failures(, ([\d]+) pending)?/m

    def fetch_rspec_stats(str)
      matches = str.scan(RSPEC_PATTERN)
      return if matches.empty?

      result = { count: 0, failures: 0, pending: 0 }

      matches.each do |m|
        result[:count]    += m[0].to_i if m[0] # examples
        result[:failures] += m[1].to_i if m[1] # failures
        result[:pending]  += m[3].to_i if m[3] # pending
      end

      result
    end
  end
end