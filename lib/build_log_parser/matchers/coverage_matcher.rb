module BuildLogParser
  module CoverageMatcher
    PATTERNS = {
      rspec:    /\s([\d]+) \/ ([\d]+) LOC \(([\d]+\.[\d]+)%\) covered\./,
      phpunit:  /Lines:\s+([\d.]+)% \(([\d]+)\/([\d]+)\)/,
      istanbul: /Lines\s+:\s+([\d.]+)% \(\s([\d]+)\/([\d]+)\s\)/
    }

    def fetch_coverage(str)
      fetch_rspec_coverage(str) ||
      fetch_phpunit_coverage(str) ||
      fetch_istanbul_coverage(str)
    end

    protected

    def fetch_rspec_coverage(str)
      if body =~ PATTERNS[:rspec]
        {
          lines_covered:    $1.to_i,
          lines_total:      $2.to_i,
          coverage_percent: $3.to_f
        }
      end
    end

    def fetch_phpunit_coverage(str)
      if body =~ PATTERNS[:phpunit]
        {
          lines_covered:    $2.to_i,
          lines_total:      $3.to_i,
          coverage_percent: $1.to_f
        }
      end
    end

    def fetch_istanbul_coverage(str)
      if body =~ PATTERNS[:istanbul]
        {
          lines_covered:    $2.to_i,
          lines_total:      $3.to_i,
          coverage_percent: $1.to_f
        }
      end
    end
  end
end
