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

  def numbers_matrix
    @numbers_matrix ||= chars_matrix.map { |line| line.map(&:to_i) }
  end

  def chars_matrix
    @chars_matrix ||= lines.map(&:strip).map { |line| line.strip.split('') }
  end

  def part1
    raise NotImplementedError
  end

  def part2
    raise NotImplementedError
  end
end
