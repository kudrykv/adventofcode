# frozen_string_literal: true

module Y2018
  class Day04 < InputReader
    def part1
      guard = nil
      sleep = nil
      guards = Hash.new { |h, k| h[k] = Hash.new(0) }

      lines.sort.each do |line|
        case line
        when /Guard #(\d+) begins shift/
          guard = ::Regexp.last_match(1).to_i
        when /00:(\d\d)\] falls asleep/
          sleep = ::Regexp.last_match(1).to_i
        when /00:(\d\d)\] wakes up/
          (sleep...::Regexp.last_match(1).to_i).each { |m| guards[guard][m] += 1 }
        end
      end

      guard = guards.max_by { |_, m| m.values.sum }[0]
      minute = guards[guard].max_by { |_, v| v }[0]

      guard * minute
    end
  end
end
