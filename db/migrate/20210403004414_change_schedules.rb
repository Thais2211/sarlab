class ChangeSchedules < ActiveRecord::Migration[5.2]
  def change
    drop_table :schedules
    
    create_table :schedules do |t|
      t.timestamp :start
      t.timestamp :end
      t.references :equipament 
      t.references :laboratory
      t.references :user, foreign_key: true
      t.string :status
      t.references :type_reservation
      t.integer :admin

      t.timestamps
    end
  end
end
