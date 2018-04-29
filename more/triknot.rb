
require_relative '../helpers.rb'

class Triknot

  Y_OFFSET = 50
  R = 80
  N = 3
  FAC_HZ = 0.1
  FAC_SP = 0.1
  FAC_CN = 0.5

  class Spread < Struct.new(:point, :mid, :outer, :hz1, :o1inner, :o1outer, :counter2, :hz2, :o2inner, :o2outer, :counter1)
    def initialize(arg)
      point, next_point = arg

      next_to_outer = -(1 - (N-2)/(2.0*N)) * Math::PI
      triangle_angle = (-1/3.0)*Math::PI
      fac_sp_2 = (1-FAC_SP)/2

      outer = next_point.rotate2d(next_to_outer, point)
      mid = avg([point, outer])

      triangle = outer.rotate2d(triangle_angle, point)
      horizontal = (1-FAC_HZ)*triangle + FAC_HZ*mid
      o_inner = FAC_SP*outer + fac_sp_2*point + fac_sp_2*triangle
      o_outer = fac_sp_2*outer + FAC_SP*point + fac_sp_2*triangle
      counter = o_inner.rotate2d(Math::PI, point)*(1 - FAC_CN) + point*FAC_CN

      orignal = [horizontal, o_inner, o_outer, counter]
      reflection = Matrix.reflection2dp(outer, point)
      reflected = orignal.map { |p| reflection*p }

      super(point, mid, outer, *orignal, *reflected)
    end

    def to_2d_s_h
      to_h.map do |k, p|
        [k, p.to2d_s]
      end.to_h
    end
  end

  def chain
    s = symmetry(N)
    ring = s.map { |angle| p(0, -R).rotate2d(angle).tranlsate2d(p(0, Y_OFFSET)) }

    spreads = (ring + ring.take(1)).each_cons(2).map(&Spread.method(:new))

    triplets = (spreads + spreads.take(2)).each_cons(3).to_a

    ordered_triplets = triplets.each_with_index.sort_by do |x, i|
      i.odd? ? 1 : 0
    end.map(&:first)

    chain = ordered_triplets.map do |triplet|
      s0, s1, s2 = triplet.map(&:to_2d_s_h)
      [
        s0[:outer],
        "C #{s0[:o1outer]} #{s0[:o1inner]} #{s0[:point]}",
        "C #{s0[:counter2]} #{s1[:hz1]} #{s1[:mid]}",
        "C #{s1[:hz2]} #{s2[:counter1]} #{s2[:point]}",
        "C #{s2[:o2inner]} #{s2[:o2outer]} #{s2[:outer]}",
      ].join(' ')
    end.join(' L ')

    chain.gsub!(/ (-?[0-9.]+ -?[0-9.]+) L \1 /, ' \1 ')

    "M #{chain} Z"
  end

  def stroke_dashaoffset
    -30
  end

  def stroke_dasharray
    [102,71,98,96,96,98,71,162]
  end
end
