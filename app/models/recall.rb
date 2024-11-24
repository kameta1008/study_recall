class Recall < ApplicationRecord
  belongs_to :study

  validates :recall_date, presence: true
  validates :interval, presence: true

  after_update :generate_next_recall, if: :completed?

  private

  def generate_next_recall
    Rails.logger.debug "generate_next_recall: interval=#{interval}, completed=#{completed}"
    next_intervals = {
      1 => 2,  # 3日後
      2 => 4,  # 7日後
      4 => 23  # 30日後
    }

    next_interval = next_intervals[interval]
    if next_interval.nil?
      Rails.logger.debug "次の復習間隔がnilのため生成されません: interval=#{interval}"
      return
    end

    study.recalls.create!(
      recall_date: recall_date + next_interval.days,
      interval: next_interval
    )
  end

  def completed?
    completed == true
  end
end
