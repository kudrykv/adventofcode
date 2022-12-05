# frozen_string_literal: true

module Y2022
  class Day05 < InputReader
    def part1
      some_container_parsing
    end

    private

    def some_container_parsing
      reversed = serialized_containers.split("\n").reverse
      head = reversed.shift

      h = {'1': [], '2': [], '3': [], '4': [], '5': [], '6': [], '7': [], '8': [], '9': []}

      pos = ('1'..'9')
        .map { |i| [i, head.index(i)] }
        .reject { |_, index| index.nil? }
        .map { |id, index| [id, index] }
        .to_h

      reversed.each do |line|
        pos.each do |id, index|
          h[id.to_sym] << line[index]
        end
      end

      h
    end

    def serialized_containers
      @serialized_containers ||= input.split("\n\n").first
    end

    def serialized_moves
      @serialized_moves ||= input.split("\n\n").last
    end
  end
end
