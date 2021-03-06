class Sub < ApplicationRecord
  validates :title, :description, :moderator, presence: true
  belongs_to :moderator,
  class_name: :User,
  foreign_key: :user_id,
  primary_key: :id

  has_many :post_subs, dependent: :destroy, inverse_of: :sub
  has_many :posts, through: :post_subs
end
