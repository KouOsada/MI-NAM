module User::PostsHelper
  
  def text_placeholder 
    <<-"EOS".strip_heredoc
      メンズコスメや脱毛など、美容関連であればなんでもOK！
      #(半角)＋文字を組み合わせてハッシュタグも作れます。
      #初投稿 #お気に入りの化粧水
    EOS
  end
  
end
