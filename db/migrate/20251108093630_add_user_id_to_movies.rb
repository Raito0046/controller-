class AddUserIdToMovies < ActiveRecord::Migration[8.0]
  def change
    add_reference :movies, :user, null: false, foreign_key: true
  end
end
