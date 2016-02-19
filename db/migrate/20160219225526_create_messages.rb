class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :bike_id
      t.string :text, limit: 690

      t.timestamps
    end
  end
end
