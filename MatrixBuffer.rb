require 'matrix'

class MatrixBuffer
  def initialize(matrix)
    @data = build_data(matrix)
  end

  def build_data(matrix)
    data = Pointer.new(:float, matrix.row_size * matrix.column_size)
    matrix.each.with_index do |x, i|
     data[i] = x
    end
    data
  end

end
