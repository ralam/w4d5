class Sub < ActiveRecord::Base
  belongs_to(
    :moderator,
    class_name: :User,
    foreign_key: :moderator_id
  )

  has_many :post_subs
  has_many :posts, through: :post_subs, source: :post
  validates :title, :description, :moderator_id, presence: true


end
