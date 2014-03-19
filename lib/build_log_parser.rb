require "build_log_parser/version"
require "build_log_parser/parser"
require "chronic_duration"

module BuildLogParser
  def tests(str)
    self.new(str).tests
  end

  def coverage(str)
    self.new(str).coverage
  end

  def duration(str)
    self.new(str).duration
  end
end