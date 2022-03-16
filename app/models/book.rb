class Book < ApplicationRecord
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :page_views, dependent: :destroy

  scope :search, -> (search_params) do
    return if search_params.blank?

    if search_params[:search_type].to_i == 0
      title_where(search_params[:word])
        .body_where(search_params[:word])
    else
      case search_params[:search_type].to_i
      when 1 then
        word = "%#{search_params[:word]}"
      when 2 then
        word = "#{search_params[:word]}%"
      when 3 then
        word = "%#{search_params[:word]}%"
      end
      title_like(word)
        .body_like(word)
    end
  end

  scope :title_where, -> (title) { where(title: title) if title.present? }
  scope :body_where, -> (body) { where(body: body) if body.present? }

  scope :title_like, -> (title) { where('title LIKE ?', title) if title.present? }
  scope :body_like, -> (body) { where('body LIKE ?', body) if body.present? }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  class << self
    def ranking_by_favorites
      Book.left_joins(:favorites).where("IFNULL(favorites.created_at, '#{Time.current}') > ?", Time.current.ago(2.days)).group("books.id").order('count(favorites.id) desc')
    end
  end
end
