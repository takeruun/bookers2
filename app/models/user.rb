class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, presence: true

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :follower_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :followed_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower
  has_many :followings, through: :followed_relationships, source: :followed

  has_one_attached :profile_image

  scope :search, -> (search_params) do
    return if search_params.blank?

    if search_params[:search_type].to_i == 0
      name_where(search_params[:word])
    else
      case search_params[:search_type].to_i
      when 1 then
        word = "%#{search_params[:word]}"
      when 2 then
        word = "#{search_params[:word]}%"
      when 3 then
        word = "%#{search_params[:word]}%"
      end
      name_like(word)
    end
  end

  scope :name_where, -> (name) { where(name: name) if name.present? }

  scope :name_like, -> (name) { where('name LIKE ?', name) if name.present? }

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  def follow?(user)
    followed_relationships.where(followed_id: user.id).present?
  end
end
