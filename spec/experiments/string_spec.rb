require 'spec_helper'

describe String do
  describe '#<<' do
    it 'appends a character' do
      s = 'ABC'
      s << 'D'
      expect(s.size).to eq(4)
    end

    it 'cannot appends a nil', :exception do
      s = 'ABC'
      expect{s << nil}.to raise_error(TypeError)
    end
  end
end
