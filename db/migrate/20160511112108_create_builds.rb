class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |t|
      t.string :platform
      t.string :bundleIdentifier
      t.string :version
      t.string :build
      t.references :app, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
