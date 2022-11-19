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
            fabric[x][y] += [sheet.id]
          end
        end
      end

      def overlapping_claims
        fabric.flatten(1).count { |ids| ids.count > 1 }
      end

      def name_overlapping_claims
        fabric.flatten(1).each do |ids|
          next if ids.uniq.count <= 1

          ids.each { |id| dirty[id.to_s] = true }
        end

        dirty.keys
      end

      private

      def dirty
        @dirty ||= {}
      end

      def fabric
        @fabric ||= Array.new(1000) { Array.new(1000, []) }
      end
    end
  end

  class Day03 < InputReader
    def part1
      pieces.each { |piece| Fabric.mark(piece) }
      Fabric.overlapping_claims
    end

    def part2
      pieces.each { |piece| Fabric.mark(piece) }
      bad_ids = Fabric.name_overlapping_claims.map(&:to_i)

      pieces.reject { |piece| bad_ids.include?(piece.id) }
    end

    private

    def pieces
      @pieces ||= lines.map { |line| Sheet.parse(line) }
    end
  end
end
