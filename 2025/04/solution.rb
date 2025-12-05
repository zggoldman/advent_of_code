module TwentyFive
  class Day4
    NEIGHBOR_ADDRESSES = [
      [-1, -1],
      [-1,  0],
      [-1,  1],
      [ 0, -1],
      [ 0,  1],
      [ 1, -1],
      [ 1,  0],
      [ 1,  1]
    ].freeze

    def self.part_1(sample_input: false)
      locations = parse_input(get_input_filename(sample_input))
      count = 0

      i = 0
      while i < locations.size
        j = 0
        row = locations[i]

        while j < row.size
          count += 1 if can_access?(locations, i, j)
          j += 1
        end

        i += 1
      end

      count
    end

    def self.part_2(sample_input: false)
      locations = parse_input(get_input_filename(sample_input))

      next_state, cleared_count = clear_rolls(locations)
      total_removed_rolls = cleared_count

      while cleared_count > 0
        next_state, cleared_count = clear_rolls(next_state)
        total_removed_rolls += cleared_count
      end

      total_removed_rolls
    end

    def self.clear_rolls(locations)
      locations = locations.dup
      count = 0

      i = 0
      while i < locations.size
        j = 0
        row = locations[i]

        while j < row.size
          if can_access?(locations, i, j)
            count += 1
            locations[i][j] = false
          end

          j += 1
        end

        i += 1
      end

      [locations, count]
    end

    def self.can_access?(locations, i, j)
      return false unless locations[i][j]

      NEIGHBOR_ADDRESSES.count do |(di, dj)|
        next false if (i + di).negative? || (j + dj).negative?
        locations.dig(i + di, j + dj)
      end < 4
    end

    def self.parse_input(filename)
      [].tap do |banks|
        File.readlines(filename, chomp: true).each do |line|
          banks << line.chars.map { |c| c == "@" }
        end
      end
    end

    def self.get_input_filename(sample_input)
      sample_input ? '2025/04/sample_input.txt' : '2025/04/input.txt'
    end
  end
end
