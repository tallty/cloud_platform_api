class ChangeRecords < ActiveRecord::Migration[5.0]
  def change
  	change_table :records do |t|
      t.remove :end_time
      t.date :end_time
  	end
  end
end
