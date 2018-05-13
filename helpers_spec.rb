require './helpers'

describe 'symmetry' do
  it 'returns a sequence of angles' do
    expect(symmetry(3)).to eq([
      (0.0/3)*Math::PI,
      (2.0/3)*Math::PI,
      (4.0/3)*Math::PI,
    ])
    expect(symmetry(5)).to eq([
      (0.0/5)*Math::PI,
      (2.0/5)*Math::PI,
      (4.0/5)*Math::PI,
      (6.0/5)*Math::PI,
      (8.0/5)*Math::PI,
    ])
  end
end

describe 'avg' do
  it 'returns the average of a sequence of numbers' do
    expect(avg([1,2,3,4])).to eq(2.5)
    expect(avg([9,9,9])).to eq(9)
    expect(avg([5,5,5,6])).to eq(5.25)
  end
end

describe 'transform_color' do
  it 'tranforms to the same color with identity block and normalizes spelling' do
    expect(transform_color('#000000'){ |rgb| rgb }).to eq('#000000')
    expect(transform_color('#ffffff'){ |rgb| rgb }).to eq('#ffffff')
    expect(transform_color('#FFFFFF'){ |rgb| rgb }).to eq('#ffffff')
    expect(transform_color('#123456'){ |rgb| rgb }).to eq('#123456')
    expect(transform_color('000000'){ |rgb| rgb }).to eq('#000000')
    expect(transform_color('ffffff'){ |rgb| rgb }).to eq('#ffffff')
    expect(transform_color('FFFFFF'){ |rgb| rgb }).to eq('#ffffff')
    expect(transform_color('123456'){ |rgb| rgb }).to eq('#123456')
    expect(transform_color('#000'){ |rgb| rgb }).to eq('#000000')
    expect(transform_color('#fff'){ |rgb| rgb }).to eq('#ffffff')
    expect(transform_color('#FFF'){ |rgb| rgb }).to eq('#ffffff')
    expect(transform_color('#123'){ |rgb| rgb }).to eq('#112233')
    expect(transform_color('000'){ |rgb| rgb }).to eq('#000000')
    expect(transform_color('fff'){ |rgb| rgb }).to eq('#ffffff')
    expect(transform_color('FFF'){ |rgb| rgb }).to eq('#ffffff')
    expect(transform_color('123'){ |rgb| rgb }).to eq('#112233')
  end
  it 'tranforms with constant block' do
    expect(transform_color('#123456'){ |rgb| [0,0,0] }).to eq('#000000')
    expect(transform_color('#123456'){ |rgb| [1,1,1] }).to eq('#010101')
    expect(transform_color('#123456'){ |rgb| [42,42,42] }).to eq('#2a2a2a')
    expect(transform_color('#123456'){ |rgb| [255,255,255] }).to eq('#ffffff')
  end
end

describe 'darken_color' do
  context 'when amount is zero' do
    it 'transforms everything to black' do
      expect(darken_color('#000000', 0)).to eq('#000000')
      expect(darken_color('#123456', 0)).to eq('#000000')
      expect(darken_color('#ffffff', 0)).to eq('#000000')
    end
  end
  context 'when amount is one' do
    it 'keeps the color unchanged' do
      expect(darken_color('#000000', 1)).to eq('#000000')
      expect(darken_color('#123456', 1)).to eq('#123456')
      expect(darken_color('#ffffff', 1)).to eq('#ffffff')
    end
  end
  context 'when amount is 0.5' do
    it 'returns the color in between the input and black' do
      expect(darken_color('#000000', 0.5)).to eq('#000000')
      expect(darken_color('#123456', 0.5)).to eq('#091a2b')
      expect(darken_color('#ffffff', 0.5)).to eq('#808080')
    end
  end
end

describe 'lighten_color' do
  context 'when amount is zero' do
    it 'transforms everything to white' do
      expect(lighten_color('#000000', 0)).to eq('#ffffff')
      expect(lighten_color('#123456', 0)).to eq('#ffffff')
      expect(lighten_color('#ffffff', 0)).to eq('#ffffff')
    end
  end
  context 'when amount is one' do
    it 'keeps the color unchanged' do
      expect(lighten_color('#000000', 1)).to eq('#000000')
      expect(lighten_color('#123456', 1)).to eq('#123456')
      expect(lighten_color('#ffffff', 1)).to eq('#ffffff')
    end
  end
  context 'when amount is 0.5' do
    it 'returns the color in between the input and white' do
      expect(lighten_color('#000000', 0.5)).to eq('#808080')
      expect(lighten_color('#123456', 0.5)).to eq('#899aab')
      expect(lighten_color('#ffffff', 0.5)).to eq('#ffffff')
    end
  end
end

describe 'mix_color' do
  context 'when amount is zero' do
    it 'returns the second color' do
      expect(mix_color('#000000', '#ffffff', 0.0)).to eq('#ffffff')
      expect(mix_color('#ffffff', '#000000', 0.0)).to eq('#000000')
      expect(mix_color('#123456', '#654321', 0.0)).to eq('#654321')
    end
  end
  context 'when amount is one' do
    it 'returns the first color' do
      expect(mix_color('#000000', '#ffffff', 1.0)).to eq('#000000')
      expect(mix_color('#ffffff', '#000000', 1.0)).to eq('#ffffff')
      expect(mix_color('#123456', '#654321', 1.0)).to eq('#123456')
    end
  end
  context 'when amount is 0.5' do
    it 'returns the color in between the two given colors' do
      expect(mix_color('#000000', '#ffffff', 0.5)).to eq('#808080')
      expect(mix_color('#ffffff', '#000000', 0.5)).to eq('#808080')
      expect(mix_color('#123456', '#654321', 0.5)).to eq('#3c3c3c')
    end
  end
end
