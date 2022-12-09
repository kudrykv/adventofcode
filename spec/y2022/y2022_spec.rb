# frozen_string_literal: true

describe 'Y2022' do
  describe 'day 1' do
    it { expect(Y2022::Day01.new("#{__dir__}/day01_example.txt").part1).to eq 24_000 }
    it { p Y2022::Day01.new("#{__dir__}/day01.txt").part1 }
    it { expect(Y2022::Day01.new("#{__dir__}/day01_example.txt").part2).to eq 45_000 }
    it { p Y2022::Day01.new("#{__dir__}/day01.txt").part2 }
  end

  describe 'day 2' do
    it { expect(Y2022::Day02.new("#{__dir__}/day02_example.txt").part1).to eq 15 }
    it { p Y2022::Day02.new("#{__dir__}/day02.txt").part1 }
    it { expect(Y2022::Day02.new("#{__dir__}/day02_example.txt").part2).to eq 12 }
    it { p Y2022::Day02.new("#{__dir__}/day02.txt").part2 }
  end

  describe 'day 3' do
    it { expect(Y2022::Day03.new("#{__dir__}/day03_example.txt").part1).to eq 157 }
    it { p Y2022::Day03.new("#{__dir__}/day03.txt").part1 }
    it { expect(Y2022::Day03.new("#{__dir__}/day03_example.txt").part2).to eq 70 }
    it { p Y2022::Day03.new("#{__dir__}/day03.txt").part2 }
  end

  describe 'day 4' do
    it { expect(Y2022::Day04.new("#{__dir__}/day04_example.txt").part1).to eq 2 }
    it { p Y2022::Day04.new("#{__dir__}/day04.txt").part1 }
    it { expect(Y2022::Day04.new("#{__dir__}/day04_example.txt").part2).to eq 4 }
    it { p Y2022::Day04.new("#{__dir__}/day04.txt").part2 }
  end

  describe 'day 5' do
    it { expect(Y2022::Day05.new("#{__dir__}/day05_example.txt").part1).to eq 'CMZ' }
    it { p Y2022::Day05.new("#{__dir__}/day05.txt").part1 }
    it { expect(Y2022::Day05.new("#{__dir__}/day05_example.txt").part2).to eq 'MCD' }
    it { p Y2022::Day05.new("#{__dir__}/day05.txt").part2 }
  end

  describe 'day 6' do
    it { expect(Y2022::Day06.new("#{__dir__}/day06_example.txt").part1).to eq 10 }
    it { p Y2022::Day06.new("#{__dir__}/day06.txt").part1 }
    it { expect(Y2022::Day06.new("#{__dir__}/day06_example.txt").part2).to eq 29 }
    it { p Y2022::Day06.new("#{__dir__}/day06.txt").part2 }
  end

  describe 'day 7' do
    it { expect(Y2022::Day07.new("#{__dir__}/day07_example.txt").part1).to eq 95437 }
    it { p Y2022::Day07.new("#{__dir__}/day07.txt").part1 }
    it { expect(Y2022::Day07.new("#{__dir__}/day07_example.txt").part2).to eq 24_933_642 }
    it { p Y2022::Day07.new("#{__dir__}/day07.txt").part2 }
  end

  describe 'day 8' do
    it { expect(Y2022::Day08.new("#{__dir__}/day08_example.txt").part1).to eq 21 }
    it { p Y2022::Day08.new("#{__dir__}/day08.txt").part1 }
    it { expect(Y2022::Day08.new("#{__dir__}/day08_example.txt").part2).to eq 8 }
    it { p Y2022::Day08.new("#{__dir__}/day08.txt").part2 }
  end

  describe 'day 9' do
    # it { expect(Y2022::Day09.new("#{__dir__}/day09_example.txt").part1).to eq 13 }
    # it { p Y2022::Day09.new("#{__dir__}/day09.txt").part1 }
    it { expect(Y2022::Day09.new("#{__dir__}/day09_example2.txt").part2).to eq 36 }
    it { p Y2022::Day09.new("#{__dir__}/day09.txt").part2 }
  end
end
