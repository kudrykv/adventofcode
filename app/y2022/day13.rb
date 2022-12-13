# frozen_string_literal: true

module Y2022
  class Day13 < InputReader
    def part1
      groups_of_packets
        .each_with_index
        .map { |pair, index| [compare(*pair), index] }
        .reject { |cmp, _| cmp == 1 }
        .map { |_, index| index + 1 }
        .sum
    end

    def part2
      packets = groups_of_packets.flatten(1)
      packets.push([[2]], [[6]])

      sorted = packets.sort do |left, right|
        cmp = compare(left, right)

        next -1 if cmp.zero?
        next 1 if cmp == 1
        next 0 if cmp == 2
      end

      div1 = sorted.index { |packet| packet == [[2]] }
      div2 = sorted.index { |packet| packet == [[6]] }

      (div1 + 1) * (div2 + 1)
    end

    def compare(left, right)
      return 0 if left.is_a?(Integer) && right.is_a?(Integer) && left < right
      return 1 if left.is_a?(Integer) && right.is_a?(Integer) && left > right
      return 2 if left.is_a?(Integer) && right.is_a?(Integer) && left == right

      return compare([left], right) if left.is_a?(Integer) && right.is_a?(Array)
      return compare(left, [right]) if left.is_a?(Array) && right.is_a?(Integer)

      return unless left.is_a?(Array) && right.is_a?(Array)
      return 0 if left.empty? && !right.empty?
      return 1 if !left.empty? && right.empty?
      return 2 if left.empty? && right.empty?

      left.each_with_index do |lval, i|
        rval = right[i]

        return 1 if rval.nil?

        cmp = compare(lval, rval)

        return cmp if cmp < 2
      end

      return 0 if left.size < right.size

      2
    end

    def groups_of_packets
      input.split("\n\n").map do |group|
        left_str, right_str = group.split("\n")
        [JSON.parse(left_str), JSON.parse(right_str)]
      end
    end
  end
end
