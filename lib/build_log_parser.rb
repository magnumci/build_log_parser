require "build_log_parser/version"
require "build_log_parser/parser"
require "chronic_duration"

module BuildLogParser
  def self.tests(str)
    Parser.new(str).tests
  end

  def self.coverage(str)
    Parser.new(str).coverage
  end

  def self.duration(str)
    Parser.new(str).duration
  end
end