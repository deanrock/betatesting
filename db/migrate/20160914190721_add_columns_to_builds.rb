class AddColumnsToBuilds < ActiveRecord::Migration
  def change
    add_column :builds, :branch, :string
    add_column :builds, :commit, :string
    add_column :builds, :repo_url, :string
  end
end
