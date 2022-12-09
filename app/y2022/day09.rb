# frozen_string_literal: true

module Y2022
  DIRECTIONS = {
    'U' => :up,
    'D' => :down,
    'L' => :left,
    'R' => :right
  }.freeze

  class Day09 < InputReader
    def part1
      head = Knot.new
      tail = Knot.new

      moves.each do |direction, steps|
        1.upto(steps).each do
          head.method(direction).call
          tail.bring_to(head)
        end
      end

      tail.visited.uniq.count
    end

    def part2
      snake = 1.upto(10).map { Knot.new }

      moves.each do |direction, steps|
        1.upto(steps).each do
          snake.first.method(direction).call

          snake.each_cons(2) { |head, tail| tail.bring_to(head) }
        end
      end

      snake.last.visited.uniq.count
    end

    private

    def moves
      @moves ||= lines.map(&:strip).map do |line|
        direction, steps = line.split(' ')
        [DIRECTIONS[direction], steps.to_i]
      end
    end
  end

  class Knot
    attr_accessor :x, :y, :visited

    def initialize
      self.x = 0
      self.y = 0
      self.visited = [Point.new(0, 0)]
    end

    def up
      self.y += 1
    end

    def down
      self.y -= 1
    end

    def left
      self.x -= 1
    end

    def right
      self.x += 1
    end

    def touches?(head)
      (head.x - x).abs <= 1 && (head.y - y).abs <= 1
    end

    def bring_to(head)
      return if touches?(head)

      perform_movement(head)
      visited << Point.new(x, y)
    end

    def perform_movement(head)
      return fix_y(head) if head.x == x
      return fix_x(head) if head.y == y

      fix_x(head)
      fix_y(head)
    end

    def fix_y(head)
      return self.y += 1 if y < head.y

      self.y -= 1 if y > head.y
    end

    def fix_x(head)
      return self.x += 1 if x < head.x

      self.x -= 1 if x > head.x
    end

    def to_s
      "(#{x}, #{y})"
    end
  end

  class Point
    attr_accessor :x, :y

    def initialize(x, y)
      self.x = x
      self.y = y
    end

    def eql?(other)
      x == other.x && y == other.y
    end

    def hash
      x ^ y
    end
  end
end
