class PostSub < ActiveRecord::Base
  validates_uniqueness_of :post_id, scope: [:sub_id]
  belongs_to :post
  belongs_to :sub
end
