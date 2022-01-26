# frozen_string_literal: true

require 'rails_helper'

describe '投稿機能のテスト' do
  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }
  let!(:post) { create(:post, user_id: user.id, genre_id: genre.id) }
  let!(:other_post) { create(:other_post, user_id: other_user.id, genre_id: genre.id) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe '投稿一覧画面のテスト' do
    before do
      visit posts_path
    end

    context '表示内容の確認' do
      it 'URLが正しいか' do
        expect(current_path).to eq '/posts'
      end
      it '自分と他人の投稿詳細リンクが正しいか' do
        expect(page).to have_link '', href: post_path(post.user.id)
        expect(page).to have_link '', href: post_path(other_post.user.id)
      end
      it '自分と他人の投稿内容が表示されている' do
        expect(page).to have_content post.title
        expect(page).to have_content other_post.title
      end
      it '自分と他人の投稿画像が表示されている' do
        expect(page).to have_content post.post_image_id
        expect(page).to have_content other_post.post_image_id
      end
    end
  end

  describe '新規投稿画面のテスト' do
    before do
      visit new_post_path
      attach_file 'post[post_image]', "#{Rails.root}/app/assets/images/no_image.png"
      fill_in 'post[title]', with: Faker::Lorem.characters(number: 10)
      fill_in 'post[body]', with: Faker::Lorem.characters(number:50)
    end

    context '表示内容の確認' do
      it 'URLは正しいか' do
        expect(current_path).to eq '/posts/new'
      end
      it '画像投稿フォームが表示されているか' do
        expect(page).to have_field 'post[post_image]'
      end
      it 'タイトル入力のフォームが表示されているか' do
        expect(page).to have_field 'post[title]'
      end
      it '評価の星が表示されているか' do
        expect(page).to have_field 'post[evaluation]'
      end
      it '投稿内容フォームが表示されているか' do
        expect(page).to have_field 'post[body]'
      end
      it '投稿する！ボタンが表示されているか' do
        expect(page).to have_button '投稿する！'
      end
    end

    context '投稿成功のテスト' do
      it '投稿が保存されるか' do
        expect { click_button '投稿する！' }.to change(user.posts, :count).by(1)
      end
      it '投稿後のリダイレクト先は正しいか' do
        click_button '投稿する！'
        expect(current_path).to eq '/posts/' + Post.last.id.to_s
      end
    end

    context '投稿失敗のテスト' do
      it '投稿に失敗すると、エラーメッセージが表示されるか' do
        fill_in 'post[title]', with: ''
        fill_in 'post[body]', with: ''
        click_button '投稿する！'
        expect(page).to have_content '入力してください'
      end
    end
  end

  describe '投稿詳細画面のテスト' do
    before do
      visit post_path(post.id)
    end

    context '会員情報欄の確認' do
      it '投稿者の画像が表示される、リンク先が正しい' do
        expect(page).to have_link post.user.profile_image, href: user_path(post.user.id)
      end
      it '会員情報編集へのリンクが表示され、遷移先が正しい' do
        expect(page).to have_link '編集', href: edit_user_path(post.user.id)
      end
      it '投稿者のニックネームが表示される' do
        expect(page).to have_content post.user.nickname
      end
      it '投稿者の年代が表示される' do
        expect(page).to have_content post.user.age
      end
      it '投稿者の肌タイプが表示される' do
        expect(page).to have_content post.user.skin_type
      end
      it '投稿者の自己紹介が表示される' do
        expect(page).to have_content post.user.introduction
      end
      it '投稿者のフォロー数が表示される' do
        expect(page).to have_content post.user.followings
      end
      it '投稿者のフォロワー数が表示される' do
        expect(page).to have_content post.user.followers
      end
    end


    context '投稿内容の確認' do
      it '(投稿者名)さんの投稿、という表示があるか' do
        expect(page).to have_content post.user.nickname + 'さんの投稿'
      end
      it '画像が表示されているか' do
        expect(page).to have_content post.post_image
      end
      it '感情分析スコアが表示されているか' do
        expect(page).to have_content post.score
      end
      it 'タイトルが表示されているか' do
        expect(page).to have_content post.title
      end
      it 'ジャンルが表示されているか' do
        expect(page).to have_content post.genre
      end
      it '本文が表示されているか' do
        expect(page).to have_content post.body
      end
      it 'コメントフォームが表示されているか' do
        expect(page).to have_field 'comment[comment]'
      end
      it 'コメントフォームが空欄か' do
        expect(find_field('comment[comment]').text).to be_blank
      end
      it 'コメント送信ボタンが表示されているか' do
        expect(page).to have_button '送信'
      end
      it '投稿の編集リンクが表示されているか' do
        expect(page).to have_link '', href: edit_post_path(post.id)
      end
    end
    
    context '編集リンクのテスト' do
      it '編集画面へ遷移する' do
        click_link '', href: edit_post_path(post.id)
        expect(current_path).to eq '/posts/' + post.id.to_s + '/edit'
      end
    end
  end
  
  describe '投稿編集画面のテスト' do
    before do
      visit edit_post_path(post.id)
    end
    
    context '表示内容の確認' do
      it 'URLが正しいか' do
        expect(current_path).to eq '/posts/' + post.id.to_s + 'edit'
      end
      it '投稿した画像が表示されているか' do
        expect(page).to have_content post.post_image
      end
      it '画像投稿フォームが表示されているか' do
        expect(page).to have_field 'post[post_image]'
      end
      it 'タイトル編集フォームが表示されているか' do
        expect(page).to have_field 'post[title]'
      end
      it '本文編集フォームが表示されているか' do
        expect(page).to have_field 'post[body]'
      end
      it '”更新”ボタンが表示されているか' do
        expect(page).to have_button '更新'
      end
      it '”削除”ボタンが表示されているか' do
        expect(page).to have_button '削除'
      end
    end
    
    context '編集成功のテスト' do
      before do
        @old_post_title = post.title
        @old_post_body = post.body
        fill_in 'post[title]', with: Faker::Lorem.characters(number: 7)
        fill_in 'post[body]', with: Faker::Lorem.characters(number: 70)
        click_button '更新'
      end
      it 'タイトルが正しく更新されている' do
        expect(post.reload.title).not_to eq @old_post_title
      end
      it '本文が正しく更新されている' do
        expect(post.reload.body).not_to eq @old_post_body
      end
      it 'リダイレクト先：更新後の投稿詳細画面' do
        expect(current_path).to eq '/posts/' + post.id.to_s
        expect(page).to have_content '内容を更新しました！'
      end
    end
    
    context '更新失敗のテスト' do
      it '更新に失敗して、エラーメッセージが表示されるか' do
        fill_in 'post[title]', with: ''
        fill_in 'post[body]', with: ''
        click_button '更新'
        expect(page).to have_content '入力してください'
      end
    end
  end
end