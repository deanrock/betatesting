class AddQrCacheToBuild < ActiveRecord::Migration
  def change
    add_column :builds, :qr_cache, :string
  end
end
