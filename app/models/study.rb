class Study < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :recalls, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true
end
