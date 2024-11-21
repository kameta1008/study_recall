class Recall < ApplicationRecord
  belongs_to :study

  validates :recall_date, presence: true
  validates :interval, presence: true

  after_update :generate_next_recall, if: :completed?

  private

  def generate_next_recall
    next_intervals = {
      1 => 2,  # 3日後
      2 => 4,  # 7日後
      4 => 23  # 30日後
    }

    next_interval = next_intervals[interval]
    return unless next_interval

    study.recalls.create!(
      recall_date: recall_date + next_interval.days,
      interval: next_interval
    )
  end

  def completed?
    completed == true
  end
end
