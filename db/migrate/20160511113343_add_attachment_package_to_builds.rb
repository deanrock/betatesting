class AddAttachmentPackageToBuilds < ActiveRecord::Migration
  def self.up
    change_table :builds do |t|
      t.attachment :package
    end
  end

  def self.down
    remove_attachment :builds, :package
  end
end
