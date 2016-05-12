class AddIdentifierToApps < ActiveRecord::Migration
  def change
    add_column :apps, :identifier, :string
  end
end
