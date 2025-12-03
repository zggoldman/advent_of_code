class Dial
  attr_reader :position
  attr_reader :size
  attr_reader :zero_clicks

  def initialize(size, starting_position)
    @size = size
    @position = starting_position
    @zero_clicks = starting_position.zero? ? 1 : 0
  end

  def rotate_right(d)
    # Each full rotation will click past zero once.
    full_rotations = d / size
    @zero_clicks += full_rotations

    # The remaining partial rotation clicked past zero if the new position is
    # less than the original position and the original position is not
    # already 0.
    new_position = (position + d) % size
    @zero_clicks += 1 if (new_position.zero? || new_position < position) && !position.zero?

    @position = new_position
  end

  def rotate_left(d)
    # Each full rotation will click past zero once.
    full_rotations = d / size
    @zero_clicks += full_rotations

    # The remaining partial rotation clicked past zero if the new position is
    # greater than the original position and the original position is not
    # already 0.
    new_position = (position - d) % size
    @zero_clicks += 1 if (new_position.zero? || new_position > position) && !position.zero?

    @position = new_position
  end

  def rotate_to(position)
    @position = position
  end
end

module TwentyFive
  class Day1
    def self.part_1
      dial = Dial.new(100, 50)
      zero_count = 0

      File.readlines('01/input.txt', chomp: true).each do |line|
        direction = line[0]
        distance = line[1..].to_i

        if direction == "L"
          dial.rotate_left(distance)
        else
          dial.rotate_right(distance)
        end

        zero_count += 1 if dial.position.zero?
      end

      zero_count
    end

    def self.part_2(sample_input: false)
      dial = Dial.new(100, 50)
      zero_count = 0

      input_file = test_input ? '01/sample_input.txt' : '01/input.txt'

      File.readlines(input_file, chomp: true).each do |line|
        direction = line[0]
        distance = line[1..].to_i

        if direction == "L"
          dial.rotate_left(distance)
        else
          dial.rotate_right(distance)
        end
      end

      dial.zero_clicks
    end
  end
end
