module TwentyFive
  class Day2
    def self.part_1(sample_input: false)
      ranges = parse_ranges(get_input_filename(sample_input))

      invalid_codes = ranges.flat_map do |range|
        range.find_all do |code|
          str_code = code.to_s
          next false if str_code.size.odd?

          str_code[0...str_code.size / 2] == str_code[str_code.size / 2..]
        end
      end

      invalid_codes.sum
    end

    def self.part_2(sample_input: false)
      ranges = parse_ranges(get_input_filename(sample_input))

      invalid_codes = ranges.flat_map do |range|
        range.find_all do |code|
          str_code = code.to_s

          (1..str_code.size / 2).any? do |n|
            # Can't be evenly divided so it can't repeat.
            next false if str_code.size % n > 0

            str_code
              .chars
              .each_slice(n)
              .each_cons(2)
              .all? { |a, b| a == b }
          end
        end
      end

      invalid_codes.sum
    end

    def self.parse_ranges(filename)
      [].tap do |ranges|
        File.readlines(filename, chomp: true).each do |line|
          ranges.concat(
            line.split(",").map do |raw_range|
              start_code, end_code = raw_range.split("-").map(&:to_i)
              (start_code..end_code)
            end
          )
        end
      end
    end

    def self.get_input_filename(sample_input)
      sample_input ? '02/sample_input.txt' : '02/input.txt'
    end
  end
end
