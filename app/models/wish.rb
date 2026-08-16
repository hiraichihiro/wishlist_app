class Wish < ApplicationRecord
  has_many :savings, dependent: :destroy

  validates :title, presence: true
  validates :target_amount, presence: true, numericality: { greater_than: 0 }

  # 現在の貯金合計額を計算するメソッド
  def total_saved
    savings.sum(:amount)
  end

  # 進捗率（%）を計算するメソッド
  def progress_percentage
    return 0 if target_amount.nil? || target_amount.zero?
    [(total_saved.to_f / target_amount * 100).round, 100].min
  end
end