module BuildLogParser
  module CoverageMatcher
    PATTERN = /\s([\d]+) \/ ([\d]+) LOC \(([\d]+\.[\d]+)%\) covered\./

    def fetch_coverage(str)
      if body =~ PATTERN
        {
          lines_covered:    $1.to_i,
          lines_total:      $2.to_i,
          coverage_percent: $3.to_f
        }
      end
    end
  end
end