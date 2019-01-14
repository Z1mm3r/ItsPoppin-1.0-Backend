class CreateVisits < ActiveRecord::Migration[5.2]
  def change
    create_table :visits do |t|
      t.decimal :rating
      t.integer :user_id
      t.integer :establishment_id

      t.timestamps
    end
  end
end
