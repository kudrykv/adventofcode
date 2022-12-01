# frozen_string_literal: true

module Y2022
  class Day01 < InputReader
    def part1
      elves_calories.max
    end

    def part2
      elves_calories.last(3).sum
    end

    def elves_calories
      input.split("\n\n").map { |line| line.split("\n").map(&:to_i).sum }.sort
    end
  end
end
