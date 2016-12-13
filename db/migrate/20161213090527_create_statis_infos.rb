class CreateStatisInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :statis_infos do |t|
      t.references :user, foreign_key: true
      t.references :interface_document, foreign_key: true

      t.timestamps
    end
  end
end
