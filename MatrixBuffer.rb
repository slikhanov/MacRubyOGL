require 'matrix'

class Vector
  def magnitude
    Math.sqrt(@elements.inject(0) {|v, e| v + e*e})
  end

  def normalize
    n = magnitude
    raise ZeroVectorError, "Zero vectors can not be normalized" if n == 0
    self / n
  end
end

class Matrix
  def self.scale(x, y, z)
    Matrix.diagonal(x, y, z, 1)
  end

  def self.translate(x, y, z)
    Matrix[[1.0, 0.0, 0.0, x],
           [0.0, 1.0, 0.0, y],
           [0.0, 0.0, 1.0, z],
           [0.0, 0.0, 0.0, 1.0]]
  end

  def self.rotate(x, y, z, angle)
    rot = Vector[x, y, z].normalize
    c = Math.cos(angle)
    s = Math.sin(angle)
    t = 1 - c
    Matrix[
      [t*(rot[0]**2)+c,          t*rot[0]*rot[1]-s*rot[2], t*rot[0]*rot[2]+s*rot[1], 0.0],
      [t*rot[0]*rot[1]+s*rot[2], t*(rot[1]**2)+c,          t*rot[1]*rot[2]-s*rot[0], 0.0],
      [t*rot[0]*rot[2]-s*rot[1], t*rot[1]*rot[2]+s*rot[0], t*(rot[2]**2)+c,          0.0],
      [0.0,                      0.0,                      0.0,                      1.0]]
  end

  def self.perspective(fov, aspect, znear, zfar)
    xymax = znear * Math.tan(fov * PI_OVER_360)
    ymin = -xymax
    xmin = -xymax

    width = xymax - xmin
    height = xymax - ymin

    depth = zfar - znear
    q = -(zfar + znear) / depth
    qn = -2.0 * (zfar * znear) / depth

    w = 2.0 * znear / width
    w = w / aspect
    h = 2 * znear / height

    Matrix[
      [w, 0, 0, 0],
      [0, h, 0, 0],
      [0, 0, q, -1],
      [0, 0, qn, 0]]
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
