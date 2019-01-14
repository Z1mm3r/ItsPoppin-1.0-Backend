class AddDescriptionToEstablishments < ActiveRecord::Migration[5.2]
  def change
    add_column :establishments, :description, :string
  end
end
