class ChangeRatingAgain < ActiveRecord::Migration[5.2]
  def change
    remove_column :establishments, :rating
    change_column :visits, :rating, :integer, :default => 3
  end
end
