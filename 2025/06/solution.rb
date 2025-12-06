module TwentyFive
  class Day6
    def self.part_1(sample_input: false)
      worksheet = parse_human(get_input_filename(sample_input))

      worksheet.map do |column|
        numbers = column[0...-1].map(&:to_i)
        operator = column.last

        perform_operation(numbers, operator)
      end.sum
    end

    def self.part_2(sample_input: false)
      worksheet = parse_cephalopod(get_input_filename(sample_input))

      worksheet.map do |(numbers, operator)|
        perform_operation(numbers, operator)
      end.sum
    end

    def self.parse_human(filename)
      lines = []

      File.readlines(filename, chomp: true).each do |line|
        line.split(" ").each.with_index do |number, i|
          lines[i] ||= []
          lines[i] << number
        end
      end

      lines
    end

    def self.parse_cephalopod(filename)
      lines = []

      File.readlines(filename, chomp: true).each do |line|
        lines << line
      end

      max_length = lines.max_by(&:size).size

      transposed_lines = lines[0...-1]
        .map { |l| l.ljust(max_length, " ") }
        .map(&:chars)
        .transpose
        .slice_after { |e| e.all? { |n| n == " " } }

      transposed_lines.map do |line|
        line.map(&:join).map(&:strip).reject(&:empty?).map(&:to_i)
      end.zip(lines.last.split(" "))
    end

    def self.perform_operation(numbers, operator)
      if operator == "+"
        numbers.sum
      else
        numbers.reduce(1) { |acc, n| acc * n }
      end
    end

    def self.get_input_filename(sample_input)
      sample_input ? '2025/06/sample_input.txt' : '2025/06/input.txt'
    end
  end
end
