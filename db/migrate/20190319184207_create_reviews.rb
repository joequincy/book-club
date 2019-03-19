class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.references :book, foreign_key: true
      t.string :title
      t.integer :rating
      t.string :description
      t.string :user

      t.timestamps
    end
  end
end
