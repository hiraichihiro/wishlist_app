class Wish < ApplicationRecord
  has_many :savings, dependent: :destroy
  has_one_attached :image

  validates :title, presence: true
  validates :target_amount, presence: true, numericality: { greater_than: 0 }

  after_initialize :set_default_fulfilled, if: :new_record?

  def total_saved
    savings.sum(:amount)
  end

  def progress_percentage
    return 0 if target_amount.nil? || target_amount.zero?
    [((total_saved.to_f / target_amount) * 100).round, 100].min
  end

  # 残り金額
  def remaining_amount
    [target_amount - total_saved, 0].max
  end

  # 残り日数
  def remaining_days
    return nil if deadline.nil?
    (deadline.to_date - Date.current).to_i
  end

  # 1日あたりの節約目標額
  def daily_savings_target
    days = remaining_days
    return nil if days.nil? || days <= 0 || remaining_amount <= 0
    (remaining_amount.to_f / days).ceil
  end

  private

  def set_default_fulfilled
    self.fulfilled ||= false
  end
end