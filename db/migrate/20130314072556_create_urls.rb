class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :url, :unique => true
      t.string :code, :unique => true
    end
  end
end
