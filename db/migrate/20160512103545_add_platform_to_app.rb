class AddPlatformToApp < ActiveRecord::Migration
  def change
    add_column :apps, :platform, :string
  end
end
