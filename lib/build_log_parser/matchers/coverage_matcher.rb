module BuildLogParser
  module CoverageMatcher
    PATTERN = /\s([\d]+) \/ ([\d]+) LOC \(([\d]+\.[\d]+)%\) covered\./

    def fetch_coverage(str)
      fetch_rspec_coverage(str) ||
      fetch_phpunit_coverage(str) ||
      fetch_istanbul_coverage(str)
    end

    protected

    def fetch_rspec_coverage(str)
      if body =~ PATTERN
        {
          lines_covered:    $1.to_i,
          lines_total:      $2.to_i,
          coverage_percent: $3.to_f
        }
      end
    end

    def fetch_phpunit_coverage(str)
      if body =~ /Lines:\s+([\d.]+)% \(([\d]+)\/([\d]+)\)/
        {
          lines_covered:    $2.to_i,
          lines_total:      $3.to_i,
          coverage_percent: $1.to_f
        }
      end
    end

    def fetch_istanbul_coverage(str)
      if body =~ /Lines\s+:\s+([\d.]+)% \(\s([\d]+)\/([\d]+)\s\)/
        {
          lines_covered:    $2.to_i,
          lines_total:      $3.to_i,
          coverage_percent: $1.to_f
        }
      end
    end
  end
end
