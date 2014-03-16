module BuildLogParser
  class Parser
    attr_reader :body

    def initialize(body)
      @body = body
    end

    def tests
      rspec_stats || test_unit_stats
    end

    def duration
      patterns = [
        /^finished in (.*)\n?/i,
        /^finished tests in (.*),/i,
        /ran [\d]+ tests in (.*)\n?/i,
        /time: (.*), memory:/i
      ]

      patterns.map { |p| scan_duration(p) }.compact.reduce(:+)
    end

    def coverage
      if body =~ /\s([\d]+) \/ ([\d]+) LOC \(([\d]+\.[\d]+)%\) covered\./
        {
          lines:            $1.to_i,
          lines_total:      $2.to_i,
          coverage_percent: $3.to_f
        }
      else
        nil
      end
    end

    private

    def scan_duration(pattern)
      matches = body.scan(pattern)
      return if matches.empty?

      matches.flatten.map { |m| ChronicDuration.parse(m) }.reduce(:+)
    end

    def rspec_stats
      matches = body.scan(/^([\d]+) examples, ([\d]+) failures(, ([\d]+) pending)?/m)
      return if matches.empty?

      result = { count: 0, failures: 0, pending: 0 }

      matches.each do |m|
        result[:count]    += m[0].to_i if m[0] # examples
        result[:failures] += m[1].to_i if m[1] # failures
        result[:pending]  += m[3].to_i if m[3] # pending
      end

      result
    end

    def test_unit_stats
      if body =~ /^([\d]+) tests, ([\d]+) assertions, ([\d]+) failures, ([\d]+) errors$/m
        {
          count:    $1.to_i,
          failures: $3.to_i,
          pending:  nil
        }
      end
    end
  end
end