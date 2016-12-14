class ScondChangeAppointments < ActiveRecord::Migration[5.0]
  def change
  	change_table :appointments do |t|
      t.remove :limit_time
      t.integer :range
  	end
  end
end
