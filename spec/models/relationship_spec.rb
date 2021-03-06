# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Relationshipモデルのテスト', type: :model do
  describe 'アソシエーションのテスト' do
    context 'Follower(User)モデルとの関係' do
      it '1:Nとなっているか' do
        expect(Relationship.reflect_on_association(:follower).macro).to eq :belongs_to
      end
    end
    
    context 'Followed(User)モデルとの関係' do
      it '1:Nとなっているか' do
        expect(Relationship.reflect_on_association(:followed).macro).to eq :belongs_to
      end
    end
  end
end