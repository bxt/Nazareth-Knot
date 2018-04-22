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

  def self.reflection2d(r)
    Matrix[ [Math.cos(2*r), Math.sin(2*r), 0], [Math.sin(2*r), -Math.cos(2*r), 0], [0, 0, 1] ]
  end

  def self.reflection2dp(p1, p2)
    p1.to_tranlsation2d*reflection2d(p1.angle2d(p2))*(-p1).to_tranlsation2d
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

  def angle2d(other)
    diff = (other-self)
    Math.atan2(diff.y, diff.x)
  end

  def to2d_s(precision=3)
    "#{'%g' % x.round(precision)} #{'%g' % y.round(precision)}"
  end
end
