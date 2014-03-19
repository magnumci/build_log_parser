module BuildLogParser
  module DurationMatcher
    PATTERNS = [
      /^finished in (.*)/i,
      /^finished tests in ([\d]\.[\d]+s),/i,
      /ran [\d]+ tests in (.*)\n?/i,
      /time: (.*), memory:/i
    ]

    def fetch_duration(str)
      PATTERNS.map { |p| scan_duration(str, p) }.compact.reduce(:+)
    end

    private

    def scan_duration(str, pattern)
      str.
        scan(pattern).
        flatten.
        map { |m| ChronicDuration.parse(m) }.
        reduce(:+)
    end
  end
end