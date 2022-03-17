class Group < ApplicationRecord
  belongs_to :owner, class_name: 'User'

  validates :name, presence: true
  validates :introduction, presence: true

  has_one_attached :image

  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end
end
