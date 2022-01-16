# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Messageモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { message.valid? }
    
    let(:user) { create(:user) }
    let(:room) { create(:room) }
    let!(:message) { build(:message, user_id: user.id, room_id: room.id) }
    
    context 'contentカラム' do
      it '空欄ではないこと' do
        message.content = ''
        is_expected.to eq false
      end
    end
  end
  
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it '1:Nとなっているか' do
        expect(Message.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    
    context 'Roomモデルとの関係' do
      it '1:Nとなっているか' do
        expect(Message.reflect_on_association(:room).macro).to eq :belongs_to
      end
    end
    
    context 'Notificationモデルとの関係' do
      it '1:Nとなっているか' do
        expect(Message.reflect_on_association(:notification).macro).to eq :has_many
      end
    end
  end
end