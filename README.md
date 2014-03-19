# build_log_parser

Fetch metrics from build logs: tests, duration, coverage, etc.

[![Build Status](https://magnum-ci.com/status/eb64be07cb99aaa701aa902522f11ffa.png)](https://magnum-ci.com/public/71629b4f296ef091fc02/builds)
[![Code Climate](https://codeclimate.com/github/magnumci/build_log_parser.png)](https://codeclimate.com/github/magnumci/build_log_parser)

## Installation

Install via rubygems:

```
gem install build_log_parser
```

Or with bundler:

```
gem "build_log_parser"
```

## Usage

Build log parser library provides an ability to fetch various metrics from build
logs. Supports tests, coverage and duration metrics.

Example log output:

```
Finished in 2 minutes 23.4 seconds
1169 examples, 0 failures, 17 pending
Coverage report generated for RSpec to /app/coverage. 3816 / 4835 LOC (78.92%) covered.
```

Example usage:

``` ruby
require "build_log_parser"

# Initialize parser
parser = BuildLogParser::Parser.new(str)

# Get tests metrics
parser.tests
# => {:count=>1169, :failures=>0, :pending=>17}

# Get coverage metrics
parser.coverage
# => {:lines_covered=>3816, :lines_total=>4835, :coverage_percent=>78.92}

# Get duration
parser.duration
# => 143.4 (in seconds)
```

## Tests

Execute test suite by running the following command:

```
bundle exec rake test
```

## License

The MIT License

Copyright (c) 2014 Magnum CI