class AddFrequencyToInterfaceDocuments < ActiveRecord::Migration[5.0]
  def change
  	add_column :interface_documents, :frequency, :integer, default: 0
  end
end
