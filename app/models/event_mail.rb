class EventMail < ApplicationRecord
  belongs_to :group

  validates :title, presence: true
  validates :content, presence: true
end
