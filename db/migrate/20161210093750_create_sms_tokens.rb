class CreateSmsTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :sms_tokens do |t|
      t.string :phone
      t.string :token

      t.timestamps
    end
  end
end
