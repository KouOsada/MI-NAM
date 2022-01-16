# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'モデルのテスト', type: :model do
  describe 'アソシエーションのテスト' do
    context 'Entryモデルとの関係' do
      it '1:Nとなっているか' do
        expect(Relationship.reflect_on_association(:entry).macro).to eq :has_many
      end
    end
    context 'Messageモデルとの関係' do
      it '1:Nとなっているか' do
        expect(Relationship.reflect_on_association(:message).macro).to eq :has_many
      end
    end
    context 'Notificationモデルとの関係' do
      it '1:Nとなっているか' do
        expect(Relationship.reflect_on_association(:notification).macro).to eq :has_many
      end
    end
  end
end