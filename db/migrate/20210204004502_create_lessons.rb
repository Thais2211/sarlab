class CreateLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :lessons do |t|
      t.date :date_start
      t.date :date_end
      t.references :laboratory, foreign_key: true
      t.references :professor, foreign_key: {to_table: :users}
      t.string :day1
      t.time :hour1
      t.string :day2
      t.time :hour2
      t.string :day3
      t.time :hour3

      t.timestamps
    end
  end
end
