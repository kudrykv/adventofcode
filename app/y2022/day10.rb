# frozen_string_literal: true

module Y2022
  class Day10 < InputReader
    def part1
      gpu = GPU.new

      commands.each { |command| gpu.execute(command) }

      gpu.inspection_results.sum
    end

    def part2
      gpu = GPU.new

      commands.each { |command| gpu.execute(command) }

      gpu.render_crt
    end

    private

    def commands
      lines.map(&:strip).map { |line| line.split(' ') }.map do |cmd, arg|
        arg = arg.to_i

        case cmd
        when 'addx'
          AddX.new(arg)
        when 'noop'
          Noop.new(arg)
        end
      end
    end
  end

  class GPU
    attr_accessor :timer, :register_x, :crt, :inspection_results
    attr_reader :inspects

    def initialize
      @timer = 0
      @register_x = 1
      @crt = []
      @inspects = (20..220).step(40).to_a
      @inspection_results = []
    end

    def execute(command)
      loop do
        break if command.ready?

        push_to_crt
        self.timer += 1
        command.tick
        inspection_results << signal_strength if inspects.include?(timer)
        self.register_x += command.argument if command.ready?
      end
    end

    def push_to_crt
      return crt << '#' if ((timer % 40) - register_x).abs <= 1

      crt << '.'
    end

    def signal_strength
      timer * register_x
    end

    def render_crt
      crt.each_slice(40).map(&:join).join("\n")
    end
  end

  class Command
    attr_reader :argument
    attr_accessor :timer

    def initialize(arg)
      @argument = arg
      @timer = 0
    end

    def ready?
      timer == ticks
    end

    def tick
      self.timer += 1
    end

    def ticks
      raise NotImplementedError
    end
  end

  class Noop < Command
    def ticks
      1
    end
  end

  class AddX < Command
    def ticks
      2
    end
  end
end
