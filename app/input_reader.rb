# frozen_string_literal: true

class InputReader
  attr_reader :lines

  def initialize(file)
    @lines = File.readlines(file)
  end

  def input
    @input ||= lines.join('')
  end

  def numbers
    @numbers ||= lines.map(&:strip).map(&:to_i)
  end

  def part1
    raise NotImplementedError
  end

  def part2
    raise NotImplementedError
  end
end
