class CreateHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :histories do |t|
      t.integer :user_id
      t.integer :good_id
    end  
  end
end
