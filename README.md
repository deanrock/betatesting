# betatesting
Lightweight version of old TestFlight for over-the-air installation of iOS and Android applications.

## Features

* supports iOS apps
* supports Android apps
* API for uploading .ipa/.apk
* parses app package and displays version, build number, etc.
* log-in via GitLab OAuth2
* link to GitLab commit on build page

## Configuration
Config is read from config/config.yml file. Example config file for development (change `development` to `production` for production environment) is below:
```yaml
development:
  gitlab_api_key: apikey
  gitlab_secret_key: secretkey
  gitlab_url: http://gitlab.example.com
  SLACK_API_TOKEN: xoxb-token
  api_token: key-for-uploading-api
```

