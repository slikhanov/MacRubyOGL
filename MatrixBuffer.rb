require 'matrix'

class Matrix
  def self.scale(vector)
     Matrix.diagonal(*vector)
  end

  def self.scale_comp(x, y, z)
    self.scale(Vector[x, y, z, 1])
  end
end

class MatrixBuffer
  def initialize(matrix)
    @data = build_data(matrix)
  end

  def build_data(matrix)
    data = Pointer.new(:float, matrix.row_size * matrix.column_size)
    matrix.each.with_index { |x, i| data[i] = x }
    data
  end

end
