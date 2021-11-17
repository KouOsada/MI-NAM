class Room < ApplicationRecord

  has_many :entries, dependent: :destroy
  has_many :massages, dependent: :destroy

end
