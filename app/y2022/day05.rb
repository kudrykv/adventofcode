# frozen_string_literal: true

module Y2022
  class Day05 < InputReader
    def part1
      crates = crate_ground

      parsed_moves.each { |amount, from, to| crates.move_one_by_one(amount, from, to) }

      crates.tops
    end

    def part2
      crates = crate_ground

      parsed_moves.map { |amount, from, to| crates.move_all_at_once(amount, from, to) }

      crates.tops
    end

    private

    def parsed_moves
      @parsed_moves ||= serialized_moves
                        .split("\n")
                        .map { |line| line.scan(/\d+/) }
                        .map { |amount, from, to| [amount.to_i, from.to_sym, to.to_sym] }
    end

    def crate_ground
      reversed = serialized_containers.split("\n").reverse
      head = reversed.shift

      h = { '1': [], '2': [], '3': [], '4': [], '5': [], '6': [], '7': [], '8': [], '9': [] }

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

      clean_hash = cleanup_parsed_hash(h)
      crates = hash_to_crates(clean_hash)

      CraneGround.new(crates)
    end

    def cleanup_parsed_hash(hash)
      hash.map { |k, v| [k, v.reject(&:nil?).map(&:strip).reject(&:empty?)] }
          .reject { |_, v| v.empty? }
    end

    def hash_to_crates(hash)
      hash.map { |id, list| Crate.new(id, list.map { |item| Container.new(item) }) }
    end

    def serialized_containers
      @serialized_containers ||= input.split("\n\n").first
    end

    def serialized_moves
      @serialized_moves ||= input.split("\n\n").last
    end
  end

  class CraneGround
    attr_reader :crates

    def initialize(crates)
      @crates = crates
    end

    def move_one_by_one(amount, from, to)
      from_crate = crates.find { |crate| crate.id == from }
      to_crate = crates.find { |crate| crate.id == to }

      pick = from_crate.pop(amount).reverse

      to_crate.push(*pick)
    end

    def move_all_at_once(amount, from, to)
      from_crate = crates.find { |crate| crate.id == from }
      to_crate = crates.find { |crate| crate.id == to }

      pick = from_crate.pop(amount)

      to_crate.push(*pick)
    end

    def tops
      crates.map(&:top).join('')
    end
  end

  class Crate
    attr_reader :id, :stack

    def initialize(id, stack)
      @id = id
      @stack = stack
    end

    def pop(amount)
      stack.pop(amount)
    end

    def push(*containers)
      stack.push(*containers)
    end

    def top
      stack.last
    end
  end

  class Container
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def to_s
      name
    end
  end
end
