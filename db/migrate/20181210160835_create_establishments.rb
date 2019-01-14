class CreateEstablishments < ActiveRecord::Migration[5.2]
  def change
    create_table :establishments do |t|
      t.string :name
      t.string :domain
      t.decimal :rating
      t.string :genre
      t.string :picture_url

      t.timestamps
    end
  end
end
