class ThirdChangeApponitments < ActiveRecord::Migration[5.0]
  def change
  	change_table :appointments do |t|
      t.remove :interface_document_id
  	end
  end
end
