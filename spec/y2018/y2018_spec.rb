require 'rspec'

describe 'Y2018' do
  describe 'day 1' do
    it { p Y2018::Day01.new("#{__dir__}/day01.txt").part1 }
    it { p Y2018::Day01.new("#{__dir__}/day01.txt").part2 }
  end

  describe 'day 2' do
    it { p Y2018::Day02.new("#{__dir__}/day02.txt").part1 }
    it { p Y2018::Day02.new("#{__dir__}/day02.txt").part2 }
  end

  describe 'day 3' do
    it { p Y2018::Day03.new("#{__dir__}/day03.txt").part1 }
    it { p Y2018::Day03.new("#{__dir__}/day03.txt").part2 }
  end

  describe 'day 4' do
    it { p Y2018::Day04.new("#{__dir__}/day04.txt").part1 }
    it { p Y2018::Day04.new("#{__dir__}/day04.txt").part2 }
    it { expect(Y2018::Day04.new("#{__dir__}/day04_example.txt").part2).to eq 4455 }
  end
end
