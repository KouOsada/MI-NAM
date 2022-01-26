# frozen_string_literal: true

require 'rails_helper'

describe '検索機能のテスト' do
  let(:user) { create(:user) }
  let!(:post) { create(:post) }
  
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
    visit root_path
  end
  
  describe '検索のテスト：ユーザー(検索結果がある場合)' do
    before do
      fill_in 'word', with: user.name
      select 'ユーザー', from: 'range'
      select '完全一致', from: 'search'
      find('.search-icon').click
    end
    
    context '表示内容の確認' do
      it '「"入力値"の検索結果」と表示される' do
        expect(page).to have_content "#{word}" + ' の検索結果'  
      end
      it 'ユーザーの画像が表示される：リンクはユーザー詳細画面' do
        expect(page).to have_link user.profile_image_id, href: user_path(user.id)
      end
      it 'ニックネームが表示される：リンクはユーザー詳細画面' do
        expect(page).to have_link user.nickname, href: user_path(user.id)
      end
      it 'フォローボタンが表示される' do
        expect(page).to have_link '', href: user_relationships_path(user.id)
      end
    end
  end
  
  describe '検索のテスト：ユーザー（検索結果がない場合）' do
    before do
      fill_in 'word', with: ''
      find('.search-icon').click
    end
    
    context '表示の確認' do
      it '「""の検索結果」と表示される' do
        expect(page).to have_content "#{word}" + ' の検索結果'  
      end
    end
  end
  
  describe '検索のテスト：投稿（検索結果がある場合）' do
    before do
      fill_in 'word', with: post.title
      select '投稿記事', from: "range"
      select '完全一致', from: 'search'
      find('.search-icon').click
    end
    
    context '表示の確認' do
      it '「""の検索結果」と表示される' do
        expect(page).to have_content "#{word}" + ' の検索結果'  
      end
      it '投稿のタイトルが表示されている：リンクは投稿詳細画面' do
        expect(page).to have_link post.title, href: post_path(post.id)
      end
      it '投稿画像が表示されている：リンクは投稿詳細画面' do
         expect(page).to have_link post.post_image_id, href: post_path(post.id)
      end
    end
  end
  
  describe '検索のテスト：投稿（検索結果がない場合）' do
    before do
      fill_in 'word', with: ''
      select '投稿', from: 'range'
      select '完全一致', from: 'search'
      find('.search-icon').click
    end
    
    context '表示の確認' do
      it '「""の検索結果」と表示される' do
        expect(page).to have_content "#{word}" + ' の検索結果'  
      end
    end
  end
end