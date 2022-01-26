# frozen_string_literal: true

require 'rails_helper'

describe '会員のテスト' do
  let(:user) { create(:user) }
  
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]'. with: user.password
    click_button 'ログイン'
  end
  
  describe '会員詳細画面のテスト' do
    it 'URLが正しい' do
      expect(current_path).to eq '/users/' + user.id.to_s
    end
    it '画像が表示される、リンク先が正しい' do
      expect(page).to have_link user.profile_image, href: user_path(user.id)
    end
    it '編集へのリンクが表示され、遷移先が正しい' do
      expect(page).to have_button '編集', href: edit_user_path(user.id)
    end
    it 'ニックネームが表示される' do
      expect(page).to have_content user.nickname
    end
    it '年代が表示される' do
      expect(page).to have_content user.age
    end
    it '肌タイプが表示される' do
      expect(page).to have_content user.skin_type
    end
    it '自己紹介が表示される' do
      expect(page).to have_content user.introduction
    end
    it 'フォロー数が表示される' do
      expect(page).to have_content user.followings
    end
    it 'フォロワー数が表示される' do
      expect(page).to have_content user.followers
    end
  end
  
  describe '編集画面のテスト' do
    before do
      visit edit_user_path(user.id)
    end
    
    context '表示内容の確認' do
      it 'URLが正しいか' do
        expect(current_path).to eq '/users/' + user.id.to_s + '/edit'
      end
      it '「会員情報編集」と表示されているか' do
        expect(page).to have_content '会員情報編集'
      end
      it 'プロフィール画像が表示されているか' do
        expect(page).to have_content user.profile_image_id
      end
      it 'プロフィール画像の投稿フォームがあるか' do
        expect(page).to have_field 'user[profile_image]'
      end
      it 'ニックネームの入力フォームがあるか' do
        expect(page).to have_field 'user[nickname]'
      end
      it 'メールアドレスの入力フォームがあるか' do
        expect(page).to have_field 'user[email]'
      end
      it 'プロフィール紹介の入力フォームがあるか' do
        expect(page).to have_field 'user[introduction]'
      end
      it '「変更を保存」ボタンがあるか' do
        expect(page).to have_button '変更を保存'
      end
      it '退会確認画面へのリンクはあるか' do
        expect(page).to have_link 'こちら', href: unsubscribe_path(user.id)
      end
    end
    
    context '更新成功のテスト' do
      before do
        @old_user_nickname = user.nickname
        @old_user_introduction = user.introduction
        fill_in 'user[nickname]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[introduction]', with: Faker::Lorem.characters(number: 50)
        click_button '変更を保存'
      end
      it 'ニックネームが正しく更新される' do
        expect(user.nickname).not_to eq @old_user_nickname
      end
      it 'プロフィール紹介が正しく更新される' do
        expect(user.introduction).not_to eq @old_user_introduction
      end
      it 'リダイレクト先はマイページ' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
    end
  end
  
  describe '退会確認画面のテスト' do
    before do
      visit unsubscribe_path
    end
    
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/unsubscribe/' + user.id.to_s
      end
      it '「本当に退会しますか？」の表示がある' do
        expect(page).to have_content '本当に退会しますか？'
      end
      it '「退会しない」ボタンがある：リンク先はマイページ' do
        expect(page).to have_button '退会しない', href: user_path(user.id)
      end
      it '「退会する」ボタンがある' do
        expect(page).to have_button '退会する'
      end
      it '「退会する」ボタンを押すと退会する' do
        click_button '退会する'
        expect(user.reload.is_deleted).to eq true
      end
    end
  end
end