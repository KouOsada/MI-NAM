# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Commentモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { comment.valid? }
    
    let!(:user) { create(:user) }
    let!(:post) { create(:post, user_id: user.id) }
    let!(:comment) { build(:comment, user_id: user.id, post_id: post.id) }
    
    context 'commentカラム' do
      it '空欄でないこと' do
        post.title = ''
        is_expected.to eq false
      end
      it '150文字以下であること: 150文字はOK' do
        post.body = Faker::Lorem.characters(number: 150)
        is_expected.to eq true
      end
      it '150文字以下であること: 151文字はNG' do
        post.body = Faker::Lorem.characters(number: 151)
        is_expected.to eq false
      end
    end
  end
  
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it '1:Nとなっているか' do
        expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    
    context 'Postモデルとの関係' do
      it '1:Nとなっているか' do
        expect(Comment¥.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
    
    context 'Nptificationモデルとの関係' do
      it '1:Nとなっているか' do
        expect(Comment.reflect_on_association(:post).macro).to eq :has_many
      end
    end
  end
end