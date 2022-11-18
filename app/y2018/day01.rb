# frozen_string_literal: true

module Y2018
  class Day01
    attr_reader :input

    def initialize(file)
      @input = File.readlines(file).map(&:strip)
    end

    def numbers
      @numbers ||= input.map(&:to_i)
    end

    def part1
      numbers.sum
    end

    def part2
      sum = 0
      loop do
        numbers.each do |n|
          sum += n
          return sum if frequencies[sum.to_s.to_sym]

          frequencies[sum.to_s.to_sym] = true
        end
      end
    end

    private

    def frequencies
      @frequencies ||= { '0': true }
    end
  end
end
