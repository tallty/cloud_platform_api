class ChangeUserInfo < ActiveRecord::Migration[5.0]
  def change
  	change_table :user_infos do |t|
    t.string :email
  	end
  end
end
