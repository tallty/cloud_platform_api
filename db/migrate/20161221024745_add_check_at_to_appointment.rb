class AddCheckAtToAppointment < ActiveRecord::Migration[5.0]
  def change
  	change_table :appointments do |t|
      t.date :checke_at
  	end
  end
end
