class CreateRatings < ActiveRecord::Migration
  def change
      create_table :ratings do |t|
        t.integer :severity, default: 0
        t.references :rateable, polymorphic: true, index: true

        t.timestamps null: false
      end
      add_index :ratings, :rateable_id  
  end
end
