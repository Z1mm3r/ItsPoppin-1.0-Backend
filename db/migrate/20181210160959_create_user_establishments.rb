class CreateUserEstablishments < ActiveRecord::Migration[5.2]
  def change
    create_table :user_establishments do |t|
      t.integer :user_id
      t.integer :establishment_id
      t.timestamps
    end
  end
end
