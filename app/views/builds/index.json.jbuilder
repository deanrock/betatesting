json.array!(@builds) do |build|
  json.extract! build, :id, :platform, :bundleIdentifier, :version, :build, :app_id
  json.url build_url(build, format: :json)
end
