class Comment < ApplicationRecord
  belongs_to :post

  belongs_to :author,
  class_name: :User,
  foreign_key: :author_id

  has_many :child_comments,
  class_name: :Comment,
  foreign_key: :parent_comment_id

end
