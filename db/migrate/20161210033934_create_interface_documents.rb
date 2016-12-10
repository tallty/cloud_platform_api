class CreateInterfaceDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :interface_documents do |t|
      t.string :title
      t.text :description
      t.string :site

      t.timestamps
    end
  end
end
