class CreateWishes < ActiveRecord::Migration[7.2]
  def change
    create_table :wishes do |t|
      t.string :title
      t.integer :target_amount
      t.date :deadline
      t.string :image_url
      t.string :link_url
      t.text :memo

      t.timestamps
    end
  end
end
