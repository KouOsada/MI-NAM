# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Favoriteモデルのテスト', type: :model do
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it '1:Nとなっているか' do
        expect(Favorite.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    
    context 'Postモデルとの関係' do
      it '1:Nとなっているか' do
        expect(Favorite.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end
end