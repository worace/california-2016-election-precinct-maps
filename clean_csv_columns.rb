#!/usr/bin/env ruby
require 'csv'

# Using this as a bit of a hack to clean up csv output
# from the all_precinct_results file -- specifically some
# rows are missing data for the final column but don't include
# an additional comma to separate the last (empty) column from
# the next-to-last (populated) column, and because of this postgres
# will reject them on import.

# Reads from stdin and writes to stdout
CSV do |csv|
  orig = CSV($stdin, headers: true)
  csv << orig.first.headers
  orig.each do |r|
    csv << r
  end
end
