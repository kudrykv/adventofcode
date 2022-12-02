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
end
