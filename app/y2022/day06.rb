# frozen_string_literal: true

module Y2022
  class Day06 < InputReader
    def part1
      word = words(4).second

      input.index(word) + 3
    end

    def part2
      word = words(14).first

      input.index(word) + 14
    end

    private

    def words(size)
      input
        .split('')
        .each_cons(size)
        .filter { |chars| chars.uniq.size == chars.size }
        .map(&:join)
    end
  end
end
