# frozen_string_literal: true

module Y2022
  class Day03 < InputReader
    def part1
      rucksacks.map(&:duplicates).flatten.map(&:priority).sum
    end

    def part2
      rucksacks
        .each_slice(3).map { |rucksacks| ElvesGroup.new(rucksacks) }
        .map(&:common)
        .map(&:all)
        .flatten
        .map(&:priority)
        .sum
    end

    def rucksacks
      @rucksacks ||= lines.map(&:strip).map { |line| Rucksack.parse(line) }
    end
  end

  class ElvesGroup
    attr_reader :rucksacks

    def initialize(rucksacks)
      @rucksacks = rucksacks
    end

    def common
      rucksacks.reduce(rucksacks.first) { |acc, rucksack| Rucksack.new(acc.all & rucksack.all) }
    end
  end

  class Rucksack
    def self.parse(line)
      items = line.split('').map { |char| Item.new(char) }

      Rucksack.new(items)
    end

    attr_reader :left, :right

    def initialize(items)
      half = items.length / 2

      @left = items[0...half]
      @right = items[half..]
    end

    def duplicates
      left & right
    end

    def all
      left + right
    end
  end

  class Item
    ORDER = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

    attr_reader :item

    def initialize(item)
      @item = item
    end

    def priority
      ORDER.index(item) + 1
    end

    def eql?(other)
      item == other.item
    end

    def hash
      item.ord
    end

    def to_s
      item
    end
  end
end
