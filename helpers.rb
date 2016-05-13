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
    "#{'%g' % x.round(precision)} #{'%g' % y.round(precision)}"
  end

end

class StrokeDash
  def initialize(offset, *steps)
    @offset = offset
    @steps = steps
  end

  def css(shrink_by=0, precision=3)
    css_properties(@steps.map.with_index{ |a, i| a + (i.odd? ? 1 : -1)*shrink_by }, @offset - shrink_by/2, precision)
  end

  private

  def css_properties(array, offset, precision)
    result = "stroke-dasharray: #{array.map{ |a| '%g' % a.round(precision) }.join(',')};"
    result += " stroke-dashoffset: #{'%g' % offset.round(precision)};" unless offset == 0
    result
  end
end

def symmetry(n)
  (0...n).map{|i| i/n.to_f*Math::PI*2}
end

def avg(xs)
  xs.reduce(&:+) / xs.length.to_f
end

def page_intro(title, theme=:white)
  puts <<-HTML.gsub(/^ {4}/, '')
    <title>#{title}</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
      * { padding: 0; margin: 0; }
      body { background: ##{:white.eql?(theme) ? "fff" : "000"}; width: 100%; height: 100%; font-family: "Avenir Next", "Helvetica Neue", Arial, sans-serif;}
      body, h1 { font-weight: 100; }
      a { opacity: 0.7; }
      #content { position: absolute; bottom: 10px; right: 10px; color: #999; }
      svg { max-height: 100%; max-width: 100%; }
    </style>
    <div id="content">
    <h1>#{title}</h1>
    <p>By <a href="http://bernhardhaeussner.de">Bernhard Häussner</a>, May 2016.<br/>Code on <a href="https://github.com/bxt/Nazareth-Knot">GitHub</a>.</p>
    </div>
  HTML
end
