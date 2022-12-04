# frozen_string_literal: true

module Y2022
  class Day04 < InputReader
    def part1
      parse_sections.select(&:any_cover?).count
    end

    def part2
      parse_sections.select(&:overlaps?).count
    end

    private

    def parse_sections
      @parse_sections ||= lines.map { |line| line.split(',') }.map(&method(:parse_sections_pair))
    end

    def parse_sections_pair(list)
      left, right = list
      left_section = Section.parse(left)
      right_section = Section.parse(right)
      SectionsPair.new(left_section, right_section)
    end
  end

  class SectionsPair
    attr_reader :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    def any_cover?
      left.cover?(right) || right.cover?(left)
    end

    def overlaps?
      left.overlaps?(right)
    end
  end

  class Section
    def self.parse(string)
      from, to = string.split('-').map(&:to_i)
      new(from, to)
    end

    attr_reader :range

    def initialize(from, to)
      @range = from..to
    end

    def cover?(other)
      range.cover?(other.range)
    end

    def overlaps?(other)
      range.overlaps?(other.range)
    end
  end
end
