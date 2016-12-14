class CreateAppointmentItems < ActiveRecord::Migration[5.0]
  def change
    create_table :appointment_items do |t|
      t.references :interface_document, foreign_key: true
      t.references :appointment, foreign_key: true
      t.string :aasm_state

      t.timestamps
    end
  end
end
