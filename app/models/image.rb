class Image < ActiveRecord::Base
  belongs_to :user
  mount_uploader :file, PictureUploader
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 150}
  #validates :file, presence: true
  validate :picture_size

  def picture_size
	if file.size > 5.megabytes
		errors.add(:file, "should be less than 5MB")
	end
  end
end
