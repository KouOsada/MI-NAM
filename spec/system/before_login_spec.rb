# frozen_string_literal: true

require 'rails_helper'

describe 'ユーザーログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end
      
    context '表示の確認' do
      it 'URLが正しいか' do
          expect(current_path).to eq '/'
      end
      it '投稿一覧のアイコンが表示されている' do
          posts_link = find_all('a')[5].native.inner_text
          expect(posts_link).to match(/投稿一覧/)
      end
      it '投稿一覧のリンク先が正しい' do
          posts_link = find_all('a')[5].native.inner_text
          expect(page).to have_link posts_link, href: posts_path
      end
      it 'アバウト画面のリンクが表示されている' do
          about_link = find_all('a')[6].native.inner_text
          expect(about_link).to match(/MI-NAMについて/)
      end
      it 'アバウト画面のリンク先が正しい' do
          about_link = find_all('a')[6].native.inner_text
          expect(page).to have_link about_link, href: about_path
      end
      it '新規登録のリンクが表示されている' do
          signup_link = find_all('a')[7].native.inner_text
          expect(signup_link).to match(/新規登録/)
      end
      it '新規登録のリンク先が正しい' do
          signup_link = find_all('a')[7].native.inner_text
          expect(page).to have_link signup_link, href: new_user_registration_path
      end
      it 'ログインのリンクが表示されている' do
          login_link = find_all('a')[8].native.inner_text
          expect(login_link).to match(/ログイン/)
      end
      it 'ログインのリンク先が正しい' do
          login_link = find_all('a')[8].native.inner_text
          expect(page).to have_link login_link, href: new_user_session_path
      end
    end
  end
  
  describe 'about画面のテスト' do
    before do
      visit about_path
    end
    
    context '表示の確認' do
      it 'URLが正しいか' do
        expect(current_path).to eq '/about'
      end
    end
  end
end