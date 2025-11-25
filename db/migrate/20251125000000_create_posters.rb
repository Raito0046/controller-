class CreatePosters < ActiveRecord::Migration[8.0]
  def change
    create_table :posters do |t|
      t.string :title, null: false
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end