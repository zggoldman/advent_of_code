module TwentyFive
  class Day3
    def self.part_1(sample_input: false)
      banks = parse_banks(get_input_filename(sample_input))
      banks.map { |bank| array_as_number(largest_number_n_digits(bank, 2)) }.sum
    end

    def self.part_2(sample_input: false)
      banks = parse_banks(get_input_filename(sample_input))
      banks.map { |bank| array_as_number(largest_number_n_digits(bank, 12)) }.sum
    end

    def self.largest_number_n_digits(arr, n, acc = [])
      return acc if n <= 0
      return acc.concat(arr) if arr.size <= n

      max = arr.first
      max_index = 0

      i = 1
      while i <= arr.size - n
        if arr[i] > max
          max = arr[i]
          max_index = i
        end

        i += 1
      end

      largest_number_n_digits(arr[(max_index + 1)..], n - 1, acc << max)
    end

    def self.array_as_number(arr)
      arr.each.with_index.reduce(0) do |acc, (n, i)|
        acc += n * 10 ** (arr.size - i - 1)
      end
    end

    def self.parse_banks(filename)
      [].tap do |banks|
        File.readlines(filename, chomp: true).each do |line|
          banks << line.chars.map(&:to_i)
        end
      end
    end

    def self.get_input_filename(sample_input)
      sample_input ? '2025/03/sample_input.txt' : '2025/03/input.txt'
    end
  end
end
