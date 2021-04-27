class CreateTypeReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :type_reservations do |t|
      t.string :description

    end

    execute <<-SQL
      INSERT INTO type_reservations (description) VALUES ('AULA');
      INSERT INTO type_reservations (description) VALUES ('TRABALHO');
    SQL
  end
end
