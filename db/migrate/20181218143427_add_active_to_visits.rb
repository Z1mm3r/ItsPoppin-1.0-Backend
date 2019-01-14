class AddActiveToVisits < ActiveRecord::Migration[5.2]
  def change
    add_column :visits, :active, :boolean, null: false, default: false
  end
end
