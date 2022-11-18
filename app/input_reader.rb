# frozen_string_literal: true

class InputReader
  attr_reader :input

  def initialize(file)
    @input = File.readlines(file).map(&:strip)
  end

  def numbers
    @numbers ||= input.map(&:to_i)
  end
end
