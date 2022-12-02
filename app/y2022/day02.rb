# frozen_string_literal: true

module Y2022
  class Day02 < InputReader
    def part1
      play.map(&:score).sum
    end

    def part2
      series_of_outcomes.map(&:opposite).map(&:score).sum
    end

    private

    def play
      series_of_rounds.map do |opponent_move, my_move|
        round(opponent_move, my_move)
      end
    end

    def round(opponent_move, my_move)
      return RoundResult.new(my_move, Win.new) if my_move.beats?(opponent_move)
      return RoundResult.new(my_move, Lose.new) if opponent_move.beats?(my_move)

      RoundResult.new(my_move, Draw.new)
    end

    def series_of_rounds
      lines.map do |line|
        opponent_move, my_move = line.split(' ')

        [parse_opponent_move(opponent_move), parse_as_move(my_move)]
      end
    end

    def series_of_outcomes
      lines.map do |line|
        opponent_move, outcome = line.split(' ')
        move = parse_opponent_move(opponent_move)
        result = parse_as_outcome(outcome)

        RoundResult.new(move, result)
      end
    end

    def parse_opponent_move(move)
      return Rock.new if move == 'A'
      return Paper.new if move == 'B'
      return Scissors.new if move == 'C'

      raise ArgumentError, "Invalid move: #{move}"
    end

    def parse_as_move(move)
      return Rock.new if move == 'X'
      return Paper.new if move == 'Y'
      return Scissors.new if move == 'Z'

      raise ArgumentError, "Invalid move: #{move}"
    end

    def parse_as_outcome(result)
      return Lose.new if result == 'X'
      return Draw.new if result == 'Y'
      return Win.new if result == 'Z'

      raise ArgumentError, "Invalid result: #{result}"
    end
  end

  class RoundResult
    attr_reader :move, :result

    def initialize(move, result)
      @move = move
      @result = result
    end

    def opposite
      return self if result.is_a?(Draw)
      return RoundResult.new(move.beats, result) if result.is_a?(Lose)

      RoundResult.new(move.opposite, result) if result.is_a?(Win)
    end

    def score
      move.points + result.points
    end
  end

  class Win
    def opposite
      Lose.new
    end

    def points
      6
    end
  end

  class Lose
    def opposite
      Win.new
    end

    def points
      0
    end
  end

  class Draw
    def opposite
      self
    end

    def points
      3
    end
  end

  class Rock
    def beats
      Scissors.new
    end

    def beats?(other)
      other.is_a?(Scissors)
    end

    def opposite
      Paper.new
    end

    def points
      1
    end
  end

  class Paper
    def beats
      Rock.new
    end

    def beats?(other)
      other.is_a?(Rock)
    end

    def opposite
      Scissors.new
    end

    def points
      2
    end
  end

  class Scissors
    def beats
      Paper.new
    end

    def beats?(other)
      other.is_a?(Paper)
    end

    def opposite
      Rock.new
    end

    def points
      3
    end
  end
end
