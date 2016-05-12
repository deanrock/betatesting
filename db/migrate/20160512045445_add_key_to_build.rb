class AddKeyToBuild < ActiveRecord::Migration
  def change
    add_column :builds, :key, :string
  end
end
