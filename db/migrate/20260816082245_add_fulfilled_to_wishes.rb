class AddFulfilledToWishes < ActiveRecord::Migration[7.2]
  def change
    add_column :wishes, :fulfilled, :boolean
  end
end
