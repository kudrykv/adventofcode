# frozen_string_literal: true

module Y2022
  class Day12 < InputReader
    def part1
      weighted = chars_matrix.map do |row|
        row.map do |char|
          next Place.new('S', 1, 0) if char == 'S'
          next Place.new('E', 26) if char == 'E'

          Place.new(char, char.ord - 96)
        end
      end

      weighted.each_with_index do |row, y|
        row.each_with_index do |place, x|
          place.left = weighted[y][x - 1] if x.positive?
          place.right = weighted[y][x + 1]
          place.up = weighted[y - 1][x] if y.positive?
          place.down = weighted[y + 1] && weighted[y + 1][x]
        end
      end

      flat = weighted.flatten
      my_end = flat.find { |item| item.name == 'E' }

      loop do
        break if flat.all?(&:closed?)
        break if my_end.closed?

        lowest = flat.reject(&:closed?).min_by(&:distance)

        lowest.left&.set_distance(lowest.calculate_distance(lowest.left))
        lowest.right&.set_distance(lowest.calculate_distance(lowest.right))
        lowest.up&.set_distance(lowest.calculate_distance(lowest.up))
        lowest.down&.set_distance(lowest.calculate_distance(lowest.down))

        lowest.close
      end

      my_end.distance
    end
  end

  def part2
    weighted = chars_matrix.map do |row|
      row.map do |char|
        next Place.new('S', 1, 0) if char == 'S'
        next Place.new('E', 26) if char == 'E'

        Place.new(char, char.ord - 96)
      end
    end

    weighted.each_with_index do |row, y|
      row.each_with_index do |place, x|
        place.left = weighted[y][x - 1] if x.positive?
        place.right = weighted[y][x + 1]
        place.up = weighted[y - 1][x] if y.positive?
        place.down = weighted[y + 1] && weighted[y + 1][x]
      end
    end

    flat = weighted.flatten
    my_end = flat.find { |item| item.name == 'E' }


  end

  class Place
    attr_accessor :name, :height, :distance, :left, :right, :up, :down

    def initialize(name, height, distance = Float::INFINITY)
      @name = name
      @height = height
      @distance = distance
    end

    def close
      @closed = true
    end

    def closed?
      @closed
    end

    def calculate_distance(other)
      return Float::INFINITY if other.nil?
      return Float::INFINITY if other.height - height > 1

      distance + 1
    end

    def set_distance(number)
      self.distance = number if number < distance
    end
  end
end
