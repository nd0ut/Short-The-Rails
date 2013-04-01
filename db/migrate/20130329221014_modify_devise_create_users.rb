class ModifyDeviseCreateUsers < ActiveRecord::Migration
  def change
    remove_columns :users, :email, :encrypted_password,
                           :reset_password_token, :reset_password_sent_at
  end
end
