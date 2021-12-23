class ChangeLesson < ActiveRecord::Migration[5.2]
  def change
    drop_table :lessons

    create_table :lessons do |t|
      t.date :data
      t.time :start_time
      t.time :end_time
      t.references :laboratory, foreign_key: true
      t.references :disciplina, foreign_key: true
      t.boolean :review, default: false
      t.references :users
      t.date :date_review

      t.timestamps
    end
  end
end
