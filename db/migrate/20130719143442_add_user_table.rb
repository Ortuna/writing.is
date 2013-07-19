class AddUserTable < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :uid 
      t.string :role
      t.string :provider
      t.string :name
      t.string :image_url
      t.timestamps
    end
  end
end
