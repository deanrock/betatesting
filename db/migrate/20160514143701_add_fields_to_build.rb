class AddFieldsToBuild < ActiveRecord::Migration
  def change
    add_column :builds, :ipa_file_content, :string
    add_column :builds, :profile_content, :string
  end
end
