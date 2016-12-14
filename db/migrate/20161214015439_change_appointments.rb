class ChangeAppointments < ActiveRecord::Migration[5.0]
  def change
  	change_table :appointments do |t|
      t.remove :start_time, :end_time
      t.string :limit_time
  	end
  end
end
