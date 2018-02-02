class Board
  attr_reader :x_axis_length, :y_axis_length

  def initialize(x, y)
    @x_axis_length = x
    @y_axis_length = y
  end

  def coordinates
    (0..x_axis_length).map { |x| (0..y_axis_length).map { |y| {x: x, y: y} } }.flatten
  end
end
