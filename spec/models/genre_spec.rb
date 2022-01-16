# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Genreモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { genre.valid? }
    
    let(:admin) { create(:admin) }
    let!(:genre) { build(:genre) }
    
    context 'nameカラム' do
      it '空欄ではないこと' do
        genre.name = ''
        is_expected.to eq false
      end
    end
  end
  
  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it '1:Nとなっているか' do
        expect(Genre.reflect_on_association(:post).macro).to eq :has_many
      end
    end
  end
end