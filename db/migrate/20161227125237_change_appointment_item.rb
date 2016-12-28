class ChangeAppointmentItem < ActiveRecord::Migration[5.0]
  def change
  	change_table :appointment_items do |t|
      t.remove :checke_at, :range
      t.string :range
  	end
  end
end
