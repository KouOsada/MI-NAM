# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Entryモデルのテスト', type: :model do
  describe 'モデルテスト' do
    let!(:entry) { create(:entry) }
    
    it 'user_idとroom_idがある場合、有効であること' do
      expect(build(:entry)).to be_valid
    end
    it 'user_idがない場合、無効であること' do
      entry.user_id = nil
      expect(build(:entry)).to be_invalid
    end
    it 'room_idがない場合、無効であること' do
      entry.room_id = nil
      expect(build(:entry)).to be_invalid
    end
  end
  
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it '1:Nとなっているか' do
        expect(Entry.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Roomモデルとの関係' do
      it '1:Nとなっているか' do
        expect(Entry.reflect_on_association(:room).macro).to eq :belongs_to
      end
    end
  end
end