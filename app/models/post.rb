class Post < ActiveRecord::Base
  has_many :post_subs

  has_many(
    :subs,
    through: :post_subs,
    source: :sub

  )
  belongs_to(
    :author,
    class_name: :User,
    foreign_key: :author_id
  )
end
