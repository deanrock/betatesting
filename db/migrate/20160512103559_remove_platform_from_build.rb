class RemovePlatformFromBuild < ActiveRecord::Migration
  def change
    remove_column :builds, :platform, :string
  end
end
