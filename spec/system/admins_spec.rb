# frozen_string_literal: true

require 'rails_helper'

describe '管理者のテスト' do
  let(:admin) { create(:admin) }
  let!(:post) { create(:post, user_id: user.id) }
  
  before do
    visit new_admin_session_path
  end
  
  describe 'ログインのテスト' do
    context '表示の確認' do
      it 'URLが正しいか' do
        expect(current_path).to eq '/admin/sign_in'
      end
      it '管理者ログインと表示されている' do
        expect(page).to have_content '管理者ログイン'
      end
      it 'メールアドレス入力フォームが表示されている' do
        expect(page).to have_field 'admin[email]'
      end
      it 'パスワード入力フォームが表示されている' do
        expect(page).to have_field 'admin[password]'
      end
      it 'ログインボタンが表示されている' do
        expect(page).to have_button 'ログイン'
      end
    end
    
    context 'ログインテスト' do
      before do
        fill_in 'admin[email]', with: admin.email
        fill_in 'admin[password]', with: admin.password
        click_button 'ログイン'
      end
      it 'ログイン後のリダイレクト先が投稿一覧になっている' do
        expect(current_path).to eq '/admin/posts'
      end
    end
    
    context 'ログイン失敗時のテスト' do
      before do
        fill_in 'admin[email]', with: ''
        fill_in 'admin[password]', with: ''
        click_button 'ログイン'
      end
      it 'ログイン画面にリダイレクトする' do
        expect(current_path).to eq '/admin/sign_in'
      end
    end
  end
  
  describe 'ヘッダーのテスト(ログイン後)' do
    before do
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'ログイン'
    end
    
    context '表示の確認' do
      it '会員一覧のリンクがあること：左から１番目' do
        admin_users_link = find_all('a')[1].native.inner_text
        expect(admin_users_link).to match(/会員/)
      end
      it '投稿一覧のリンクがあること：左から２番目' do
        admin_posts_link = find_all('a')[2].native.inner_text
        expect(admin_posts_link).to match(/投稿/)
      end
      it 'ジャンル一覧のリンクがあること：左から３番目' do
        admin_genres_link = find_all('a')[3].native.inner_text
        expect(admin_genres_link).to match(/ジャンル/)
      end
      it 'ログアウトのリンクがあること：左から４番目' do
        admin_signout_link = find_all('a')[4].native.inner_text
        expect(admin_signout_link).to match(/ログアウト/)
      end
    end
  end
  
  describe 'ログアウトのテスト' do
    before do
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'ログイン'
      click_link 'ログアウト'
    end
    
    context 'ログアウト機能のテスト' do
      it '正しくログアウトできている：　ログアウト後のリダイレクト先にAboutリンクが存在する' do
        expect(page).to have_link '', href: '/about'
      end
      it 'ログアウト後のリダイレクト先がログイン画面になっている' do
        expect(current_path).to eq '/admin/sign_in'
      end
    end
  end
  
  describe '投稿一覧のテスト' do
    before do
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'ログイン'
      visit admin_posts_path
    end
    
    context '表示の確認' do
      it 'URLは正しいか' do
        expect(current_path).to eq '/admin/posts'
      end
      it '投稿一覧と表示されている' do
        expect(page).to have_content '投稿一覧'
      end
      it '画像のリンク先が正しい' do
        expect(page).to have_link '', href: admin_post_path(post)
      end
      it '投稿のタイトルが表示されておりその遷移先が正しい' do
        expect(page).to have_link post.title, href: admin_post_path(post)
      end
      it '投稿者名が表示されておりその遷移先が正しい' do
        expect(page).to have_link post.user.nickname, href: admin_user_path(user)
      end
      it '投稿の感情分析スコアが表示されている' do
        expect(page).to have_content post.score
      end
    end
  end
end