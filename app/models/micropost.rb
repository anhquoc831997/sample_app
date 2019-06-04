class Micropost < ApplicationRecord
  belongs_to :user
  scope :order_desc, ->{order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum:
    Settings.validates_length}
  validate  :picture_size

  private

  # Validates the size of an uploaded picture.
  def picture_size
    return errors.add(:picture, t("img_noti")) if picture.size >
                                                  Settings.img_size.megabytes
  end
end
