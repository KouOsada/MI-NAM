# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'モデルのテスト', type: :model do
  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it '1:Nとなっているか' do
        expect(Notification.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
    context 'Commentモデルとの関係' do
      it '1:Nとなっているか' do
        expect(Notification.reflect_on_association(:comment).macro).to eq :belongs_to
      end
    end
    context 'Roomモデルとの関係' do
      it '1:Nとなっているか' do
        expect(Notification.reflect_on_association(:room).macro).to eq :belongs_to
      end
    end
    context 'Messageモデルとの関係' do
      it '1:Nとなっているか' do
        expect(Notification.reflect_on_association(:message).macro).to eq :belongs_to
      end
    end
    context 'Visitor(User)モデルとの関係' do
      it '1:Nとなっているか' do
        expect(Notification.reflect_on_association(:visitor).macro).to eq :belongs_to
      end
    end
    context 'Visited(User)モデルとの関係' do
      it '1:Nとなっているか' do
        expect(Notification.reflect_on_association(:visited).macro).to eq :belongs_to
      end
    end
  end
end