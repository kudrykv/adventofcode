# frozen_string_literal: true

module Y2018
  class Day04 < InputReader
    def part1
      guard = guards.max_by { |_, m| m.values.sum }[0]
      minute = guards[guard].max_by { |_, v| v }[0]

      guard * minute
    end

    def part2
      guard, minutes = guards.max_by { |_, m| m.values.max }
      minute = minutes.max_by { |_, v| v }.first

      guard * minute
    end

    private

    def guards
      return @guards if defined?(@guards)

      @guards = Hash.new { |acc, guard| acc[guard] = Hash.new(0) }

      guard = nil
      sleep = nil

      lines.sort.each do |line|
        case line
        when /Guard #(\d+) begins shift/
          guard = ::Regexp.last_match(1).to_i
        when /00:(\d\d)\] falls asleep/
          sleep = ::Regexp.last_match(1).to_i
        when /00:(\d\d)\] wakes up/
          (sleep...::Regexp.last_match(1).to_i).each { |minute| @guards[guard][minute] += 1 }
        end
      end

      @guards
    end
  end
end
