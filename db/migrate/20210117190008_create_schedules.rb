class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.timestamp :start
      t.timestamp :end
      t.references :equipament, foreign_key: true
      t.references :laboratory, foreign_key: true
      t.references :user, foreign_key: true
      t.string :status
      t.references :type_reservation, foreign_key: true
      t.references :admin, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
