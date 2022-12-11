# frozen_string_literal: true

module Y2022
  class Day11 < InputReader
    def part1
      monkeys = list_of_monkeys

      20.times do
        monkeys.each do |monkey|
          loop do
            break if monkey.empty_bag?

            left_monkey = monkeys.find { |m| m.number == monkey.left }
            right_monkey = monkeys.find { |m| m.number == monkey.right }

            item = monkey.get
            item.worry_level = monkey.operation.call(item.worry_level) / 3

            left_monkey.take(item) if monkey.test(item.worry_level)
            right_monkey.take(item) unless monkey.test(item.worry_level)
          end
        end
      end

      monkeys.map(&:inspections).sort.last(2).reduce(:*)
    end

    def part2
      monkeys = list_of_monkeys

      div = monkeys.map(&:divisible_by).reduce(&:*)

      10_000.times do |round|
        monkeys.each do |monkey|
          loop do
            break if monkey.empty_bag?

            left_monkey = monkeys.find { |m| m.number == monkey.left }
            right_monkey = monkeys.find { |m| m.number == monkey.right }

            item = monkey.get
            item.worry_level = monkey.operation.call(item.worry_level) % div

            left_monkey.take(item) if monkey.test(item.worry_level)
            right_monkey.take(item) unless monkey.test(item.worry_level)
          end
        end
      end

      monkeys.map(&:inspections).sort.last(2).reduce(:*)
    end

    private

    def list_of_monkeys
      input.split("\n\n").map { |group| Monkey.parse(group) }
    end
  end

  class Monkey
    class << self
      def parse(group)
        monkey = Monkey.new

        group.split("\n").each_with_index do |line, index|
          case index
          when 0
            monkey.number = line.split(' ')[1].to_i
          when 1
            monkey.items = Item.parse_many(line)
          when 2
            monkey.operation = Operation.parse(line)
          when 3
            monkey.divisible_by = line.split.last.to_i
          when 4
            monkey.left = line.split.last.to_i
          when 5
            monkey.right = line.split.last.to_i
          end
        end

        monkey
      end
    end

    attr_accessor :number, :items, :operation, :divisible_by, :left, :right, :inspections

    def initialize
      @items = []
      @inspections = 0
    end

    def empty_bag?
      items.empty?
    end

    def get
      self.inspections += 1
      items.shift
    end

    def take(item)
      items << item
    end

    def test(worry_level)
      (worry_level % divisible_by).zero?
    end
  end

  class Operation
    class << self
      def parse(line)
        token1, op, token2 = line.split.last(3)

        proc do |level|
          param1 = token1 == 'old' ? level : token1.to_i
          param2 = token2 == 'old' ? level : token2.to_i

          param1.method(op.to_sym).call(param2)
        end
      end
    end
  end

  class Item
    class << self
      def parse_many(line)
        line.split(': ')[1].split(', ').map { |level| Item.new(level.to_i) }
      end
    end

    attr_accessor :worry_level

    def initialize(worry_level)
      @worry_level = worry_level
    end
  end
end
