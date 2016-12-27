class CreateRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :records do |t|
      t.date :end_time
      t.string :range
      t.references :user, foreign_key: true
      t.references :interface_document, foreign_key: true

      t.timestamps
    end
  end
end
