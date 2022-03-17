class Group < ApplicationRecord
  belongs_to :owner, class_name: 'User'

  has_many :group_users, dependent: :destroy
  has_many :members, through: :group_users, source: :user

  validates :name, presence: true
  validates :introduction, presence: true

  has_one_attached :image

  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end

  def members_name
    members.pluck(:name)
  end
end
