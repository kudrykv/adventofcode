# frozen_string_literal: true

module Y2018
  class Day05 < InputReader

    def react_polymer(input)
      input.chars.reduce([]) do |polymer, unit|
        if polymer.last == unit.swapcase
          polymer.pop
        else
          polymer << unit
        end
        polymer
      end
    end

    def part1
      react_polymer(input).count
    end

    def part2
      ('a'..'z').map do |unit|
        react_polymer(input.gsub(/#{unit}/i, '')).count
      end.min
    end
  end
end
