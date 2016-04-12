class Image < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  mount_uploader :file, PictureUploader
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 150}
  #validates :file, presence: true
  validate :picture_size

  def liked_by?(user)
    likes.each do |like|
      return like.user==user
    end
  end

  def picture_size
  	if file.size > 5.megabytes
  		errors.add(:file, "should be less than 5MB")
  	end
  end
end
