module HashtagMethods
  extend ActiveSupport::Concern
  
  # ---------------ハッシュタグ抽出メソッド(create,updateで使用)---------------
  def extract_hashtag(body)
    # 例外処理。引数がからの場合は処理しない
    if body.blank?
      return
    end
    # 入力された文字列の中から、#で始まる文字列を配列にして返す。
    return body.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
  end
  # ---------------------------------------------------------------------------
  
  # ---------------ハッシュタグ保存メソッド(create,updateで使用)---------------
  def save_hashtag(hashtag_array, post_instance)
    # ハッシュタグなしの場合実行しない
    if hashtag_array.blank?
      return
    end
    
    hashtag_array.uniq.map do |hashtag|
      # ハッシュタグは先頭の#を外し、小文字にして保存
      tag = Hashtag.find_or_create_by(name: hashtag.downcase.delete('#'))
      
      # 中間テーブルへの保存
      post_hashtag = PostHashtag.new
      post_hashtag.post_id = post_instance.id
      post_hashtag.hashtag_id = tag.id
      post_hashtag.save!
    end
  end
  # ---------------------------------------------------------------------------
  
  # -----------ハッシュタグの情報をPostオブジェクトに含めるメソッド------------
  def creating_structures(posts: "", post_hashtags: "", hashtags: "")
    array = [] #最終戻り値用
    posts.each do |post|
      hashtag = [] #中間テーブルから探したハッシュタグを格納するための配列
      post_hash = post.attributes #ActiveRecordインスタンスをハッシュに変換
      related_hashtag_records = post_hashtags.select{|ph| ph.post_id == post.id} #1.中間テーブルから投稿idが一致するレコードを取り出す
      related_hashtag_records.each do |record|
        hashtag << hashtags.detect{ |hashtag| hashtag.id == record.hashtag_id } #1をもとにハッシュタグを検索し配列に格納
      end
      post_hash["hashtags"] = hashtag #投稿データにkeyを追加、ハッシュタグのデータを格納
      array << post_hash
    end
    return array
  end
  # ---------------------------------------------------------------------------
  
  # -----ハッシュタグの情報をハッシュタグ/中間テーブルから削除するメソッド-----
  def delete_records_related_hashtag(post_id)
    relationship_records = PostHashtag.where(post_id: post_id) #中間テーブルのレコード
    if relationship_records.present? #レコードが保存されていれば、削除する
      relationship_records.each do |record|
        record.destroy
      end
    end
    all_hashtags = Hashtag.all
    all_related_records = PostHashtag.all
    all_hashtags.each do |hashtag|
      # ハッシュタグに紐づくレコードが中間テーブルに保存されていなければ、ハッシュタグを削除
      if all_related_records.none?{ |record| hashtag.id == record.hashtag_id }
        hashtag.destroy
      end
    end
  end
  # ---------------------------------------------------------------------------
  
end  
  