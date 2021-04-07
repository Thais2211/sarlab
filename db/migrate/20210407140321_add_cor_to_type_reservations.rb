class AddCorToTypeReservations < ActiveRecord::Migration[5.2]
  def change
    add_column :type_reservations, :color, :string
  end

end
