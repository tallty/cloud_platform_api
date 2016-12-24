class AddColumnToUsers < ActiveRecord::Migration[5.0]
  def change
  	change_table :users do |t|
  	  t.string :appkey
      t.string :appid
    end
  end
end