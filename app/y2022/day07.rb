# frozen_string_literal: true

module Y2022
  class Day07 < InputReader
    def part1
      tree.sizes.map { |h| h[:size] }.reject { |size| size > 100_000 }.sum
    end

    def part2
      used = tree.size
      unused = 70_000_000 - used

      tree.sizes.map { |h| h[:size] }.reject { |size| size < (30_000_000 - unused) }.min
    end

    private

    def tree
      return @tree unless @tree.nil?

      @tree = nil
      point = @tree

      lines.map(&:strip).each do |line|
        case line
        when %r{\$ cd /}
          @tree = Dir.new(name: '/')
          point = @tree
        when /\$ cd \.\./
          point = point.parent
        when /\$ cd (\w+)/
          point = point.dir(Regexp.last_match(1))
        when /\$ ls/
          next
        when /dir (\w+)/
          point.dirs << Dir.new(name: Regexp.last_match(1), parent: point)
        when /(\d+) ([\w.]+)/
          point.files << File.new(Regexp.last_match(2), Regexp.last_match(1).to_i)
        end
      end

      @tree
    end
  end

  class Dir
    attr_accessor :name, :dirs, :files, :parent

    def initialize(name:, dirs: [], files: [], parent: nil)
      @name = name
      @dirs = dirs
      @files = files
      @parent = parent
    end

    def dir(name)
      dirs.find { |dir| dir.name == name }
    end

    def sizes
      [{ name:, size: }] + dirs.flat_map(&:sizes)
    end

    def size
      return files.sum(&:size) if dirs.empty?

      dirs.sum(&:size) + files.sum(&:size)
    end

    def to_s
      name
    end
  end

  class File
    attr_accessor :name, :size

    def initialize(name, size)
      @name = name
      @size = size
    end

    def to_s
      name
    end
  end
end
