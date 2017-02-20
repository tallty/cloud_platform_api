class CreateInterfaceSorts < ActiveRecord::Migration[5.0]
  def change
    create_table :interface_sorts do |t|
      t.string :title

      t.timestamps
    end
  end
end
