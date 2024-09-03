class CreateGoods < ActiveRecord::Migration[6.1]
  def change
    create_table :goods do |t|
      t.string :good_name
      t.integer :price
      t.timestamps
    end
  end
end
