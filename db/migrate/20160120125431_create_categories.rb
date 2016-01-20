class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.references :product, index: true, foreign_key: true
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
