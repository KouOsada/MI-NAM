# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { user.valid? }
    
    let!(:other_user) { create(:user) }
    let(:user) { build(:user) }
    
    context 'nicknameカラム' do
      it '空欄でないこと' do
        user.nickname = ''
        is_expected.to eq false
      end
      it '2文字以上であること: 2文字はOK' do
        user.nickname = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '2文字以上であること: 1文字はNG' do
        user.nickname = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '30文字以下であること: 30文字はOK' do
        user.nickname = Faker::Lorem.characters(number: 30)
        is_expected.to eq true
      end
      it '30文字以下であること: 31文字はNG' do
        user.nickname = Faker::Lorem.characters(number: 31)
        is_expected.to eq false
      end
      it '一意性があること' do
        user.nickname = other_user.nickname
        is_expected.to eq false
      end
    end
    
    context 'skin_typeカラム' do
      it '空欄ではないこと' do
        user.skin_type = ''
        is_expected.to eq false
      end
    end
    
    context 'introductionカラム' do
      it '100文字以下であること: 100文字はOK' do
        user.introduction = Faker::Lorem.characters(number: 100)
        is_expected.to eq true
      end
      it '100文字以下であること: 101文字はNG' do
        user.introduction = Faker::Lorem.characters(number: 101)
      end
    end
  end
  
  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it '1:Nとなっているか' do
        expect(User.reflect_on_association(:post).macro).to eq :has_many
      end
    end
    
    context 'Favoriteモデルとの関係' do
      it '1:Nとなっているか' do
        expect(User.reflect_on_association(:favorite).macro).to eq :has_many
      end
    end
    
    context 'Commentモデルとの関係' do
      it '1:Nとなっているか' do
        expect(User.reflect_on_association(:comment).macro).to eq :has_many
      end
    end
    
    context 'Messageモデルとの関係' do
      it '1:Nとなっているか' do
        expect(User.reflect_on_association(:message).macro).to eq :has_many
      end
    end
    
    context 'Entryモデルとの関係' do
      it '1:Nとなっているか' do
        expect(User.reflect_on_association(:entry).macro).to eq :has_many
      end
    end
    
    context 'Relationshipモデルとの関係' do
      it '被フォローと1:Nとなっているか' do
        expect(User.reflect_on_association(:reverse_of_relationships).macro).to eq :has_many
      end
      it '与フォローと1:Nとなっているか' do
        expect(User.reflect_on_association(:relationships).macro).to eq :has_many
      end
      it 'フォロワーと1:Nとなっているか' do
        expect(User.reflect_on_association(:followers).macro).to eq :has_many
      end
      it 'フォローする人と1:Nとなっているか' do
        expect(User.reflect_on_association(:followings).macro).to eq :has_many
      end
    end
    
    context 'Notificationモデルとの関係' do
      it '自分からの通知関連と1:Nとなっているか' do
        expect(User.reflect_on_association(:active_notifications).macro).to eq :has_many
      end
      it '相手からの通知関連と1:Nとなっているか' do
        expect(User.reflect_on_association(:passive_notifications).macro).to eq :has_many
      end
    end
  end
end