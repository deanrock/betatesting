class Build < ActiveRecord::Base
  belongs_to :app
  has_attached_file :package,
  	:path => ':rails_root/private/system/:attachment/:id/:style/:basename.:extension'
  validates_attachment_presence :package
  validates_attachment :package, :content_type => { :content_type => ["application/zip", "multipart/x-zip", "application/x-zip-compressed", "application/octet-stream"] }
end
