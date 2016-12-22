class ChangePappointmentItems < ActiveRecord::Migration[5.0]
  def change
  	change_table :appointment_items do |t|
      t.date :checke_at
      t.integer :range
    end
  end
end
