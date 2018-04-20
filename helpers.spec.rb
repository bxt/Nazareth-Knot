require './helpers'

EPS = 0.000001

RSpec::Matchers.define :be_like_really_close_to do |expected|
  match do |actual|
    actual.row_count == expected.row_count &&
    actual.column_count == expected.column_count &&
    (actual-expected).each.reduce(&:+) < EPS
  end
end

describe 'Matrix' do
  describe '#to2d_s' do
    it 'prints points with 3 decimal digits precision' do
      expect(p(0,0).to2d_s).to(eq('0 0'))
      expect(p(1,2).to2d_s).to(eq('1 2'))
      expect(p(2.5,3.4).to2d_s).to(eq('2.5 3.4'))
      expect(p(2.5324,3.42352).to2d_s).to(eq('2.532 3.424'))
      expect(p(1,-2).to2d_s).to(eq('1 -2'))
    end
  end

  describe '#angle2d' do
    it 'returns the angle in the direction of the other point' do
      expect(p(0,0).angle2d(p(1,0))).to(eq(0))
      expect(p(0,0).angle2d(p(4,0))).to(eq(0))
      expect(p(3,0).angle2d(p(4,0))).to(eq(0))
      expect(p(3.45,10.45).angle2d(p(4.45,10.45))).to(eq(0))

      expect(p(0,0).angle2d(p(-1,0))).to(eq(Math::PI))
      expect(p(0,0).angle2d(p(-4,0))).to(eq(Math::PI))
      expect(p(3,0).angle2d(p(-4,0))).to(eq(Math::PI))
      expect(p(3.45,10.45).angle2d(p(-4.45,10.45))).to(eq(Math::PI))

      expect(p(0,0).angle2d(p(0,1))).to(eq(Math::PI/2))
      expect(p(0,0).angle2d(p(0,4))).to(eq(Math::PI/2))
      expect(p(0,3).angle2d(p(0,4))).to(eq(Math::PI/2))
      expect(p(10.45,3.45).angle2d(p(10.45,4.45))).to(eq(Math::PI/2))

      expect(p(0,0).angle2d(p(0,-1))).to(eq(-Math::PI/2))
      expect(p(0,0).angle2d(p(0,-4))).to(eq(-Math::PI/2))
      expect(p(0,3).angle2d(p(0,-4))).to(eq(-Math::PI/2))
      expect(p(10.45,3.45).angle2d(p(10.45,-4.45))).to(eq(-Math::PI/2))

      expect(p(0,0).angle2d(p(1,1))).to(be_within(EPS).of(Math::PI/4))
      expect(p(0,0).angle2d(p(4,4))).to(be_within(EPS).of(Math::PI/4))
      expect(p(0,3).angle2d(p(4,7))).to(be_within(EPS).of(Math::PI/4))
      expect(p(10.45,3.45).angle2d(p(11.45,4.45))).to(be_within(EPS).of(Math::PI/4))

      expect(p(0,0).angle2d(p(1,-1))).to(be_within(EPS).of(-Math::PI/4))
      expect(p(0,0).angle2d(p(4,-4))).to(be_within(EPS).of(-Math::PI/4))
      expect(p(0,-3).angle2d(p(4,-7))).to(be_within(EPS).of(-Math::PI/4))
      expect(p(0,3).angle2d(p(4,-1))).to(be_within(EPS).of(-Math::PI/4))
      expect(p(10.45,3.45).angle2d(p(11.45,2.45))).to(be_within(EPS).of(-Math::PI/4))
    end
  end

  describe '.reflection2d' do
    [0, Math::PI, -Math::PI, 2*Math::PI].each do |r|
      context "along the X axis (r=#{r})" do
        it 'correctly reflects' do
          reflection = Matrix.reflection2d(r)
          expect(reflection*p(0,0)).to(be_like_really_close_to(p(0,0)))
          expect(reflection*p(1,0)).to(be_like_really_close_to(p(1,0)))
          expect(reflection*p(-1,0)).to(be_like_really_close_to(p(-1,0)))
          expect(reflection*p(0,1)).to(be_like_really_close_to(p(0,-1)))
          expect(reflection*p(0,-1)).to(be_like_really_close_to(p(0,1)))
          expect(reflection*p(1,1)).to(be_like_really_close_to(p(1,-1)))
          expect(reflection*p(732.645,83.94)).to(be_like_really_close_to(p(732.645,-83.94)))
        end
      end
    end

    [Math::PI/2, -Math::PI/2, 3*Math::PI/2, -3*Math::PI/2].each do |r|
      context "along the Y axis (r=#{r})" do
        it 'correctly reflects' do
          reflection = Matrix.reflection2d(r)
          expect(reflection*p(0,0)).to(be_like_really_close_to(p(0,0)))
          expect(reflection*p(1,0)).to(be_like_really_close_to(p(-1,0)))
          expect(reflection*p(-1,0)).to(be_like_really_close_to(p(1,0)))
          expect(reflection*p(0,1)).to(be_like_really_close_to(p(0,1)))
          expect(reflection*p(0,-1)).to(be_like_really_close_to(p(0,-1)))
          expect(reflection*p(1,1)).to(be_like_really_close_to(p(-1,1)))
          expect(reflection*p(732.645,83.94)).to(be_like_really_close_to(p(-732.645,83.94)))
        end
      end
    end

    [Math::PI/4, 5*Math::PI/4, -3*Math::PI/4].each do |r|
      context "along the diagonal (r=#{r})" do
        it 'correctly reflects' do
          reflection = Matrix.reflection2d(r)
          expect(reflection*p(0,0)).to(be_like_really_close_to(p(0,0)))
          expect(reflection*p(1,0)).to(be_like_really_close_to(p(0,1)))
          expect(reflection*p(-1,0)).to(be_like_really_close_to(p(0,-1)))
          expect(reflection*p(0,1)).to(be_like_really_close_to(p(1,0)))
          expect(reflection*p(0,-1)).to(be_like_really_close_to(p(-1,0)))
          expect(reflection*p(1,1)).to(be_like_really_close_to(p(1,1)))
          expect(reflection*p(732.645,83.94)).to(be_like_really_close_to(p(83.94,732.645)))
        end
      end
    end

    [3*Math::PI/4, 7*Math::PI/4, -Math::PI/4].each do |r|
      context "along the other diagonal (r=#{r})" do
        it 'correctly reflects' do
          reflection = Matrix.reflection2d(r)
          expect(reflection*p(0,0)).to(be_like_really_close_to(p(0,0)))
          expect(reflection*p(1,0)).to(be_like_really_close_to(p(-1,0)))
          expect(reflection*p(-1,0)).to(be_like_really_close_to(p(0,1)))
          expect(reflection*p(0,1)).to(be_like_really_close_to(p(-1,0)))
          expect(reflection*p(0,-1)).to(be_like_really_close_to(p(1,0)))
          expect(reflection*p(1,1)).to(be_like_really_close_to(p(-1,-1)))
          expect(reflection*p(732.645,83.94)).to(be_like_really_close_to(p(83.94,732.645)))
        end
      end
    end
  end

  describe '.reflection2dp' do
    it 'enjoys watching a little rummy-tummy on the Discovery Channel' do
      reflection = Matrix.reflection2dp(p(3,1), p(3,5))
      expect(reflection*p(1,3)).to(be_like_really_close_to(p(5,3)))
      expect(reflection*p(3,1)).to(be_like_really_close_to(p(3,1)))
      expect(reflection*p(3,5)).to(be_like_really_close_to(p(3,5)))
    end

    it 'peels the banana from the other side' do
      reflection = Matrix.reflection2dp(p(1,3), p(5,3))
      expect(reflection*p(3,1)).to(be_like_really_close_to(p(3,5)))
      expect(reflection*p(1,3)).to(be_like_really_close_to(p(1,3)))
      expect(reflection*p(5,3)).to(be_like_really_close_to(p(5,3)))
    end

    it 'opens a can of beer in the middle of the night' do
      reflection = Matrix.reflection2dp(p(2,2), p(3,3))
      expect(reflection*p(2,2)).to(be_like_really_close_to(p(2,2)))
      expect(reflection*p(5,5)).to(be_like_really_close_to(p(5,5)))
      expect(reflection*p(4,3)).to(be_like_really_close_to(p(3,4)))
      expect(reflection*p(12,19)).to(be_like_really_close_to(p(19,12)))
    end

    it 'does what it has to do to supply for its children' do
      reflection = Matrix.reflection2dp(p(2,2), p(3,1))
      expect(reflection*p(2,2)).to(be_like_really_close_to(p(2,2)))
      expect(reflection*p(5,-1)).to(be_like_really_close_to(p(5,-1)))
      expect(reflection*p(4,3)).to(be_like_really_close_to(p(1,0)))
      expect(reflection*p(-1,2)).to(be_like_really_close_to(p(2,5)))
      expect(reflection*p(5,5)).to(be_like_really_close_to(p(-1,-1)))
    end
  end
end
