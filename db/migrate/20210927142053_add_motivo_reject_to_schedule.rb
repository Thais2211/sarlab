class AddMotivoRejectToSchedule < ActiveRecord::Migration[5.2]
  def change
    remove_column :schedules, :admin

    add_column :schedules, :admin_aproved, :integer
    add_column :schedules, :reason_rejected, :string
    add_column :schedules, :admin_rejected, :integer
    add_column :schedules, :reason_cancel, :string
    add_column :schedules, :admin_cancel, :integer
  end
end
