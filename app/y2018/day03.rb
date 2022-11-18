# frozen_string_literal: true

module Y2018
  Offset = Struct.new(:x, :y)
  Piece = Struct.new(:width, :height)

  class Sheet
    attr_reader :id, :offset, :piece

    def self.parse(str)
      /[^0-9]+(?<id>\d+) @ (?<x>\d+),(?<y>\d+): (?<width>\d+)x(?<height>\d+)/ =~ str

      new(id.to_i, Offset.new(x.to_i, y.to_i), Piece.new(width.to_i, height.to_i))
    end

    private

    def initialize(id, offset, piece)
      @id = id
      @offset = offset
      @piece = piece
    end
  end

  class Fabric
    class << self
      def mark(sheet)
        (sheet.offset.x...sheet.offset.x + sheet.piece.width).each do |x|
          (sheet.offset.y...sheet.offset.y + sheet.piece.height).each do |y|
            fabric[x][y] += 1
          end
        end
      end

      def overlapping_claims
        fabric.flatten.count { |count| count > 1 }
      end

      private

      def fabric
        @fabric ||= Array.new(1000) { Array.new(1000, 0) }
      end
    end
  end

  class Day03 < InputReader
    def part1
      pieces.each { |piece| Fabric.mark(piece) }
      Fabric.overlapping_claims
    end

    private

    def pieces
      @pieces ||= input.map { |line| Sheet.parse(line) }
    end
  end
end
