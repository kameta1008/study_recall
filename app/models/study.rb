class Study < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :recalls, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true
  
  after_create :generate_initial_recall
  def next_recall_date
    recalls.where(completed: false).order(:recall_date).pluck(:recall_date).first
  end

  private

  def generate_initial_recall
    recalls.create(recall_date: created_at.to_date + 1.day, interval: 1)
  end
end
