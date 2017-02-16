class AddNameAndCompanyToUsers < ActiveRecord::Migration[5.0]
  def change
  	change_table :users do |t|
    	t.string :company_name
    	t.string :name	
  	end
  end
end
