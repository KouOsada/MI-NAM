# frozen_string_literal: true

require 'rails_helper'

describe 'ログイン後のテスト' do
  let(:user) { create(:user) }
  
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end
  
  describe 'ヘッダーのテスト:　ログインしている場合' do
    context 'リンクの内容を確認' do
      subject { current_path }
      
      it 'アイコンを押すとトップ画面に遷移する' do
        icon_link = find_all('a')[0].native.inner_text
        click_link icon_link
        is_expected.to eq '/'
      end
      it 'マイページを押すと自分の会員詳細画面に遷移する' do
        click_link 'マイページ'
        is_expected.to eq '/users/' + user.id.to_s
      end
      it '新規投稿を押すと投稿画面に遷移する' do
        click_link '新規投稿'
        is_expected.to eq '/posts/new'
      end
      it '投稿一覧を押すと投稿一覧画面に遷移する' do
        click_link '投稿一覧'
        is_expected.to eq '/posts'
      end
      it '通知を押すと通知一覧画面に遷移する' do
        click_link '通知'
        is_expected.to eq '/notifications'
      end
      it 'ログアウトを押すとログアウトし、トップ画面に遷移する' do
        click_link 'ログアウト'
        is_expected.to eq '/'
      end
    end
  end
end