# frozen_string_literal: true

module Y2018
  class Day02 < InputReader
    def part1
      tallies_having_exactly(2).count * tallies_having_exactly(3).count
    end

    def part2
      lines.combination(2).find { |a, b| a.chars.zip(b.chars).count { |x, y| x != y } == 1 }
    end

    private

    def tallies_having_exactly(num)
      tallies.select {|tally| tally.values.include?(num) }
    end

    def tallies
      lines.map { |line| line.split('').tally }
    end
  end
end
