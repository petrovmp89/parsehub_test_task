# frozen_string_literal: true

class CreateSkus < ActiveRecord::Migration[5.2]
  def change
    create_table :skus do |t|
      t.text :image
      t.text :url
      t.text :title
      t.decimal :price, precision: 10, scale: 2, null: false
      t.text :description
      t.timestamps
    end
  end
end
