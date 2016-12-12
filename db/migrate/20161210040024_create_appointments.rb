class CreateAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
      t.references :user, index: true, foreign_key: true
      t.references :interface_document, index: true, foreign_key: true
      t.string :aasm_state
      t.date :start_time
      t.date :end_time

      t.timestamps
    end
  end
end
