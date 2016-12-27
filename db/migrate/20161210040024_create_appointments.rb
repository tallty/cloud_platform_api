class CreateAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
      t.references :user, index: true, foreign_key: true
      t.string :aasm_state
      t.integer :range

      t.timestamps
    end
  end
end
