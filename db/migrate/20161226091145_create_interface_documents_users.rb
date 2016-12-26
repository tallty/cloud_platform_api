class CreateInterfaceDocumentsUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :interface_documents_users, id: false do |t|
      t.references :user, foreign_key: true
      t.references :interface_document, foreign_key: true
    end
  end
end
