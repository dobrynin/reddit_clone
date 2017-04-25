class Post < ApplicationRecord
  validates :title, :author, presence: true
  validates :subs, length: { minimum: 1 }

  belongs_to :author,
  foreign_key: :user_id,
  primary_key: :id,
  class_name: :User

  has_many :post_subs, dependent: :destroy, inverse_of: :post
  has_many :subs, through: :post_subs

  has_many :comments
end
