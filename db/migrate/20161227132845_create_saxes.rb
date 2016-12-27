class CreateSaxes < ActiveRecord::Migration[5.0]
  def change
    create_table :saxes do |t|
      t.string :title
      t.decimal :price
      t.datetime :timestamp

      t.timestamps
    end
  end
end
