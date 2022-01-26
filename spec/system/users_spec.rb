# frozen_string_literal: true

require 'rails_helper'

describe '通知機能のテスト' do
  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }
  let(:notification) { build(:notification, visitor_id: other_user.id, visited_id: user.id) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe '通知一覧画面のテスト' do
    before do
      visit notifications_path
    end

    context '表示内容の確認' do
      it 'URLは正しいか' do
        expect(current_path).to eq '/notifications'
      end
      it '通知一覧と表示されている' do
        expect(page).to have_content '通知一覧'
      end
      it '通知がない場合は「通知がありません」と表示される' do
        expect(page).to have_content '通知がありません'
      end
    end
  end

  describe '通知のテスト' do
    it 'フォローした際に通知が送信される' do
      visit user_path(other_user.id)
      click_link 'フォロー'
      expect(notification).to be_valid
    end
  end

  describe '通知があった際の通知画面テスト' do
    before do
      visit user_path(other_user.id)
      click_link 'フォロー'
      click_link 'ログアウト'
      visit new_user_session_path
      fill_in 'user[email]', with: other_user.email
      fill_in 'user[password]', with: other_user.password
      click_button 'ログイン'
      visit notifications_path
    end

    context '表示内容の確認' do
      it '通知一覧と表示される' do
        expect(page).to have_content '通知一覧'
      end
      it 'フォローされたユーザ詳細へのリンクが表示される' do
        expect(page).to have_link user.name, href: user_path(user.id)
      end
    end
  end
end