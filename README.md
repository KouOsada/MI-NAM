# MI-NAM
![minam](https://user-images.githubusercontent.com/88307473/143388555-c32280fb-3407-41e3-9323-215fc545f1cd.png). 
![responsive-minam](https://user-images.githubusercontent.com/88307473/143388703-8772d431-d5dc-42bb-8329-e6a7fd5eebba.png)

## サイト概要
近年著しい成長を遂げる男性の美容市場。様々な製品やサービスがあり、次々と新作が生み出される中で、自分に合うものを探すのは非常に困難です。  
MI-NAMはユーザーが試したコスメや体験したサービスのレビューを投稿し、コメントを交わすことで、他人の情報をもとに未知の製品/サービスを試すきっかけづくりとなれるサイトです。  
美容先進国として知られる韓国の単語より、미용(ミヨン、美容)と남성(ナムソン、男性)を合わせて、MI-NAM(ミナム)と名付けました。

## URL
[MI-NAM(会員用)](http://18.180.224.99/) <br>
[MI-NAM(管理者用)](http://18.180.224.99/admin/sign_in)

##### 【会員アカウント】
- kim
  - メールアドレス：kim@gmail.com
  - パスワード：kkkkkk
- park
  - メールアドレス：park@gmail.com
  - パスワード：pppppp

##### 【管理者アカウント】
- メールアドレス：minam-admin@gmail.com
- パスワード：111111

### サイトテーマ
男性向けの美容関連情報を交換できる交流サイト

### テーマを選んだ理由
私は以前化粧品販売を経験しましたが、男性への接客中に最も多く頂戴したのが「どの製品を使用すべきか分からない」という意見でした。
普段美容関連商品を探す際、参考としてレビューサイトを利用すると思います。しかし一般的な美容情報サイトのレビューは、肌質や悩みの違う女性からの投稿が多く、参考にし難いのが現状です。  
この現状が美容への壁を作ってしまっていると感じたため、男性のための美容サイトを今回のテーマに設定しました。男性という同じ視点で交流をすることで、美容へのハードルを解消できるようなサイトを制作します。

### ターゲットユーザ
- 美容が好きな男性
- 自分が気になるアイテムやサービスを、レビューから参考にしたい男性
- スキンケアやメイク、また美容医療などのサービスに興味はあるが、何から始めたら良いか分からないという男性
- 男性ならではの悩みを解消したい方

### 主な利用シーン
- 自分のお気に入り製品の良さを伝えたい時
- 誰かが体験したサービスの実際の感想が知りたい時
- 美容についての悩みや気になることがあり、情報を集めたい時
- 男性向けの製品/サービスを使った際の経過を共有する時

## 機能一覧
- 会員側
  - 新規登録・ログイン/ログアウト・退会(論理削除)・編集
  - レビュー投稿
  - いいね機能(Ajax)
  - コメント機能(Ajax)
  - ハッシュタグ機能
  - PVランキング表示(impressionist)
  - フォロー機能
  - 検索機能
- 管理者側
  - ログイン/ログアウト
  - 投稿一覧・詳細表示
  - 会員一覧・詳細表示
  - ジャンル作成・編集・削除

## 設計書
- [ER図](https://drive.google.com/file/d/1854Ahzt8Wa5VZD6K63XXckEhZB2yn_Gk/view?usp=sharing)
- [テーブル定義書](https://docs.google.com/spreadsheets/d/1gGl4lP8dw79bHpRW_bITQzyknHJLB1Yr7jK7Tkv9kTg/edit?usp=sharing)
- [アプリケーション詳細設計](https://docs.google.com/spreadsheets/d/1m_Ivz8S8MI5rbcyxV4qxJyjcipN8SR3XA7mzTaHoQxs/edit?usp=sharing)

## チャレンジ要素一覧
https://docs.google.com/spreadsheets/d/1pshf_odgvj2FXlt4E1ZGLc7dWveFmdKqB9kwsV239Oc/edit?usp=sharing

## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails,Bootstrap
- JSライブラリ：jQuery
- IDE：Cloud9

## 使用素材
- [unsplash](https://unsplash.com/)