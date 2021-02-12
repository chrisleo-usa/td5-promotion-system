class CreateCategoryPromotions < ActiveRecord::Migration[6.1]
  def change
    create_table :category_promotions do |t|
      t.references :category, null: false, foreign_key: true
      t.references :promotion, null: false, foreign_key: true

      t.timestamps
    end
  end
end
