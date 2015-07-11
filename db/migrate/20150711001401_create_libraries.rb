class CreateLibraries < ActiveRecord::Migration
  def change
    create_table :libraries do |t|
      t.string :name
      t.string :street_address
      t.string :city
      t.string :zipcode
      t.string :number

      t.timestamps null: false
    end
  end
end
