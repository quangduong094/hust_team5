class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :image
	default_scope -> { order(created_at: :desc) }
	validates :content, presence: true, length: { maximum: 140 }
end
