module BuildLogParser
  class Parser
    attr_reader :body

    def initialize(body)
      @body = body
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

      total = matches.flatten.map { |m| ChronicDuration.parse(m) }.reduce(:+)
      total
    end
  end
end