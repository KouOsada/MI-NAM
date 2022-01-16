# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { post.valid? }
    
    let(:user) { create(:user) }
    let!(:post) { build(:post, user_id: user.id) }
    
    context 'titleカラム' do
      it '空欄ではないこと' do
        post.title = ''
        is_expected.to eq false
      end
    end
    
    context 'bodyカラム' do
      it '空欄ではないこと' do
        post.body = ''
        is_expected.to eq false
      end
      it '400文字以下であること: 400文字はOK' do
        post.body = Faker::Lorem.characters(number: 400)
        is_expected.to eq true
      end
      it '400文字以下であること: 401文字はNG' do
        post.body = Faker::Lorem.characters(number: 401)
        is_expected.to eq false
      end
    end
    
    context 'post_image_idカラム' do
      it '空欄ではないこと' do
        post.post_image_id = ''
        is_expected.to eq false
      end
    end
  end
  
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it '1:Nとなっているか' do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    
    context 'Genreモデルとの関係' do
      it '1:Nとなっているか' do
        expect(Post.reflect_on_association(:genre).macro).to eq :belongs_to
      end
    end
    
    context 'Favoriteモデルとの関係' do
      it '1:Nとなっているか' do
        expect(Post.reflect_on_association(:favorite).macro).to eq :has_many
      end
    end
    
    context 'Commentモデルとの関係' do
      it '1:Nとなっているか' do
        expect(Post.reflect_on_association(:comment).macro).to eq :has_many
      end
    end
    
    context 'Notificationモデルとの関係' do
      it '1:Nとなっているか' do
        expect(Post.reflect_on_association(:notification).macro).to eq :has_many
      end
    end
  end
end