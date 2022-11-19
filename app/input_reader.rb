# frozen_string_literal: true

class InputReader
  attr_reader :lines

  def initialize(file)
    @lines = File.readlines(file).map(&:strip)
  end

  def numbers
    @numbers ||= lines.map(&:to_i)
  end
end
