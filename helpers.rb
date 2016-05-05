require 'matrix'

def p(x, y)
  Matrix.point2d(x, y)
end

class Matrix
  def self.rotation2d(r)
    Matrix[ [Math.cos(r), -Math.sin(r), 0], [Math.sin(r), Math.cos(r), 0], [0, 0, 1] ]
  end

  def self.tranlsation2d(x, y)
    Matrix[ [1, 0, x], [0, 1, y], [0, 0, 1] ]
  end

  def self.scale2d(factor)
    Matrix[ [factor, 0, 0], [0, factor, 0], [0, 0, 1] ]
  end

  def self.point2d(x, y)
    Matrix.column_vector([x, y, 1])
  end

  def x
    self[0, 0]
  end

  def y
    self[1, 0]
  end

  def to_tranlsation2d
    Matrix.tranlsation2d(x, y)
  end

  def tranlsate2d(by)
    by.to_tranlsation2d*self
  end

  def rotate2d(radians, around=Matrix.point2d(0, 0))
    (around.to_tranlsation2d*Matrix.rotation2d(radians)*(-around).to_tranlsation2d*self)
  end

  def scale2d(factor, around=Matrix.point2d(0, 0))
    (around.to_tranlsation2d*Matrix.scale2d(factor)*(-around).to_tranlsation2d*self)
  end

  def distance2d(other)
    (self-other).column(0).magnitude
  end

  def to2d_s(precision=3)
    "#{x.round(precision)} #{y.round(precision)}"
  end

end

def symmetry(n)
  (0...n).map{|i| i/n.to_f*Math::PI*2}
end

def closed(xs)
  xs + [xs[0]]
end

def avg(xs)
  xs.reduce(&:+) / xs.length.to_f
end
