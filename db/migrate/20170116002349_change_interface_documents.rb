class ChangeInterfaceDocuments < ActiveRecord::Migration[5.0]
  def change
  	change_table :interface_documents do |t|
      t.string :api_type
  	end
  end
end
