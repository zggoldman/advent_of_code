module TwentyFive
  class Day5
    def self.part_1(sample_input: false)
      ranges, ingredient_ids = parse_input(get_input_filename(sample_input))

      ingredient_ids.count do |id|
        ranges.any? { |r| r.cover?(id) }
      end
    end

    def self.part_2(sample_input: false)
      ranges, _ = parse_input(get_input_filename(sample_input))

      consolidated_ranges = []

      ranges.each do |range|
        indexes = consolidated_ranges.each_index.select { |index| consolidated_ranges[index].overlap?(range) }

        if indexes
          overlapping_ranges = indexes.map { |i| consolidated_ranges[i] } << range
          consolidated_ranges.reject!.with_index { |r, i| indexes.include?(i) }

          consolidated_ranges << (overlapping_ranges.map(&:first).min..overlapping_ranges.map(&:last).max)
        else
          consolidated_ranges << range
        end
      end

      consolidated_ranges.sum(&:size)
    end

    def self.parse_input(filename)
      ranges = []
      ingredient_ids = []

      reading_ranges = true

      File.readlines(filename, chomp: true).each do |line|
        next reading_ranges = false if line.empty?

        if reading_ranges
          start_code, end_code = line.split("-").map(&:to_i)
          ranges << (start_code..end_code)
        else
          ingredient_ids << line.to_i
        end
      end

      [ranges, ingredient_ids]
    end

    def self.get_input_filename(sample_input)
      sample_input ? '2025/05/sample_input.txt' : '2025/05/input.txt'
    end
  end
end
