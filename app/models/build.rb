class Build < ActiveRecord::Base
  belongs_to :app
  has_attached_file :package,
  	:path => ':rails_root/private/system/:attachment/:id/:style/:basename.:extension'
  validates_attachment_presence :package
  validates_attachment :package, :content_type => { :content_type => ["application/zip", "multipart/x-zip", "application/x-zip-compressed", "application/octet-stream"] }
  before_create :generate_key

  def get_qr(url)
    if not self.qr_cache
      qr = RQRCode::QRCode.new(url)
      self.qr_cache = qr.as_svg(offset: 0, color: '000',
                      shape_rendering: 'crispEdges',
                      module_size: 5).to_s

      self.save
    end

    return self.qr_cache
  end

  def ipa_file
    JSON.parse(self.ipa_file_content)
  end

  def profile
    JSON.parse(self.profile_content)
  end

  def import
    # parse ios app
    platform = 'ios'

    # read ipa_file
    ipa_file = ReadIpa::IpaFile.new(self.package.path)

    identifier = ipa_file.plist['CFBundleIdentifier']
    name = ipa_file.plist['CFBundleName']

    self.version = ipa_file.plist['CFBundleShortVersionString']
    self.build = ipa_file.plist['CFBundleVersion']

    # read mobile provision file
    plist = '<plist version="1.0">' + ipa_file.mobile_provision_file.to_s.split("<plist version=\"1.0\">")[1].split("</plist>")[0] + '</plist>'

    profile = ProvisionProfile::ProvisionProfileParser.new(plist)

    self.ipa_file_content = ipa_file.plist.to_json

    begin
      self.profile_content = profile.to_json
    rescue => ex
      logger.error ex.message

      begin
        self.profile_content = profile.to_json(:except => 'Entitlements')
      rescue => ex
        logger.error ex.message
      end
    end

    if not self.app
      # find or create new app
      app = App.find_by platform: platform, identifier: identifier

      if not app
        app = App.new
        app.name = name
        app.identifier = identifier
        app.platform = platform
        app.save
      end

      self.app = app
    end

    self.save
  end

  private

  def generate_key
    while 1 do
      self.key = SecureRandom.hex(6)

      if not Build.exists?(:key => self.key)
        break
      end
    end
  end
end
