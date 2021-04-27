class RemoveAdminSchedules < ActiveRecord::Migration[5.2]
  def change
    remove_column :schedules, :admin_id
  end
end
