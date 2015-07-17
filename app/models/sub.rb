class Sub < ActiveRecord::Base
  belongs_to(
    :moderator,
    class_name: :User,
    foreign_key: :moderator_id
  )

  validates :title, :description, :moderator_id, presence: true

end
