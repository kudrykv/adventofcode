# frozen_string_literal: true

module Y2022
  class Day08 < InputReader
    def part1
      matrix = numbers_matrix.map { |row| row.map { |height| Tree.new(height) } }
      grid = Grid.new(matrix)

      grid.visible_trees
    end
  end

  class Grid
    attr_reader :matrix

    def initialize(matrix)
      @matrix = matrix
    end

    def visible_trees
      @visible = 0

      matrix.each_with_index do |row, row_index|
        row.each_with_index do |_tree, column_index|
          @visible += 1 if visible?(row_index, column_index)
        end
      end

      @visible
    end

    def visible?(row_index, column_index)
      return true if on_the_edge?(row_index, column_index)

      @left = true
      @right = true
      @top = true
      @bottom = true

      tree = matrix[row_index][column_index]

      (row_index - 1).downto(0) do |row|
        break @top = false if matrix[row][column_index].blocks_view?(tree)
      end

      (column_index - 1).downto(0) do |column|
        break @left = false if matrix[row_index][column].blocks_view?(tree)
      end

      (row_index + 1).upto(edge) do |row|
        break @bottom = false if matrix[row][column_index].blocks_view?(tree)
      end

      (column_index + 1).upto(edge) do |column|
        break @right = false if matrix[row_index][column].blocks_view?(tree)
      end

      @top || @left || @right || @bottom
    end

    def edge
      matrix.size - 1
    end

    def on_the_edge?(row_index, column_index)
      row_index.zero? || column_index.zero? || row_index == edge || column_index == edge
    end
  end

  class Tree
    attr_reader :height

    def initialize(height)
      @height = height
    end

    def blocks_view?(other)
      height >= other.height
    end

    def to_s
      height.to_s
    end
  end
end
