class Wish < ApplicationRecord
  has_many :savings, dependent: :destroy
  has_one_attached :image # ← これを追加！

  validates :title, presence: true
  validates :target_amount, presence: true, numericality: { greater_than: 0 }

  def total_saved
    savings.sum(:amount)
  end

  def progress_percentage
    return 0 if target_amount.nil? || target_amount.zero?
    [((total_saved.to_f / target_amount) * 100).round, 100].min
  end
end