class Notification < ApplicationRecord
  
  # デフォルトの並び順を作成日時の降順で指定
  default_scope -> { order(created_at: :desc) }
  # optional: true でnilを許可する
  belongs_to :post, optional: true
  belongs_to :comment, optional: true
  belongs_to :room, optional: :true
  belongs_to :message, optional: :true
  belongs_to :visitor, class_name: "User", foreign_key: "visitor_id", optional: true
  belongs_to :visited, class_name: "User", foreign_key: "visited_id", optional: true
  
end
