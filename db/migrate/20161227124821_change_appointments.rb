class ChangeAppointments < ActiveRecord::Migration[5.0]
  def change
  	change_table :appointments do |t|
      t.remove :checke_at
  	end
  end
end
