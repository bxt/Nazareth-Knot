require './matrix_2d_extensions'

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

def page_intro(title, theme=:white, date='May 2016', path=nil)
  gh = path ? "/blob/gh-pages/#{path}" : ''
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
    <p>By <a href="http://bernhardhaeussner.de">Bernhard Häussner</a>, #{date}.<br/>Code on <a href="https://github.com/bxt/Nazareth-Knot#{gh}">GitHub</a>.</p>
    </div>
  HTML
end

def darken_color(hex_color, amount)
  transform_color(hex_color) do |rgb|
    rgb.map { |c| c*amount }
  end
end

def lighten_color(hex_color, amount)
  transform_color(hex_color) do |rgb|
    rgb.map { |c| 255 - (255 - c)*amount }
  end
end

def mix_color(hex_color_a, hex_color_b, amount)
  transform_color(hex_color_a) do |rgb_a|
    transform_color(hex_color_b) do |rgb_b|
      break rgb_a.zip(rgb_b).map do |a, b|
        a*(amount) + b*(1 - amount)
      end
    end
  end
end

def transform_color(hex_color)
  rgb_in = if m = hex_color.match(/#?(\h\h)(\h\h)(\h\h)/)
    m.to_a.drop(1).map(&:hex)
  elsif m = hex_color.match(/#?(\h\h\h)/)
    m[1].chars.map{ |c| (c + c).hex }
  end
  rgb_out = yield(rgb_in)
  "#%02x%02x%02x" % rgb_out.map(&:round)
end
