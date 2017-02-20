class AddReferenceBetweenInterfaceSortAndInterfaceDocument < ActiveRecord::Migration[5.0]
  def change
  	add_reference :interface_documents, :interface_sort, index: true, foreign_key: true
  end
end
