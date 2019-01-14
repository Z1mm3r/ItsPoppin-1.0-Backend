class ChangeRating < ActiveRecord::Migration[5.2]
  def change
    change_column :establishments, :rating, :decimal, :default => 3
    change_column :visits, :rating, :decimal, :default => 3
  end
end
