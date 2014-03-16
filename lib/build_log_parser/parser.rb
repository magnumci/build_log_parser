module BuildLogParser
  class Parser
    attr_reader :body

    def initialize(body)
      @body = body
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
  end
end