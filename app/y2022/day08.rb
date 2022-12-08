# frozen_string_literal: true

module Y2022
  class Day08 < InputReader
    def part1
      grid.visible_trees
    end

    def part2
      grid.best_scenic_score
    end

    private

    def grid
      Grid.new(matrix)
    end

    def matrix
      numbers_matrix.map { |row| row.map { |height| Tree.new(height) } }
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

      left = true
      right = true
      top = true
      bottom = true

      tree = matrix[row_index][column_index]

      to_the_top(row_index, column_index) { |other_tree| break top = false if other_tree.blocks_view?(tree) }
      to_the_left(row_index, column_index) { |other_tree| break left = false if other_tree.blocks_view?(tree) }
      to_the_bottom(row_index, column_index) { |other_tree| break bottom = false if other_tree.blocks_view?(tree) }
      to_the_right(row_index, column_index) { |other_tree| break right = false if other_tree.blocks_view?(tree) }

      top || left || right || bottom
    end

    def best_scenic_score
      matrix.each_with_index do |row, row_index|
        row.each_with_index do |tree, column_index|
          tree.scenic_score = scenic_score(row_index, column_index)
        end
      end

      matrix.flatten.map(&:scenic_score).max
    end

    def scenic_score(row_index, column_index)
      return 0 if on_the_edge?(row_index, column_index)

      left = 0
      right = 0
      top = 0
      bottom = 0

      tree = matrix[row_index][column_index]

      to_the_top(row_index, column_index) do |other_tree|
        top += 1
        break if other_tree.blocks_view?(tree)
      end

      to_the_left(row_index, column_index) do |other_tree|
        left += 1
        break if other_tree.blocks_view?(tree)
      end

      to_the_bottom(row_index, column_index) do |other_tree|
        bottom += 1
        break if other_tree.blocks_view?(tree)
      end

      to_the_right(row_index, column_index) do |other_tree|
        right += 1
        break if other_tree.blocks_view?(tree)
      end

      top * left * right * bottom
    end

    def to_the_left(row_index, column_index)
      (column_index - 1).downto(0) do |column|
        yield matrix[row_index][column]
      end
    end

    def to_the_right(row_index, column_index)
      (column_index + 1).upto(edge) do |column|
        yield matrix[row_index][column]
      end
    end

    def to_the_top(row_index, column_index)
      (row_index - 1).downto(0) do |row|
        yield matrix[row][column_index]
      end
    end

    def to_the_bottom(row_index, column_index)
      (row_index + 1).upto(edge) do |row|
        yield matrix[row][column_index]
      end
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
    attr_accessor :scenic_score

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
