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

## Testing
You can test upload API via `curl` command:
```bash
curl -F "token=key-for-uploading-api" \
-F "package=@test.ipa" \
-F "slack_channel=#ci" \
-F "branch=staging" \
-F "commit=24f388298c83beb7507c6aae06b2a389dfca5b01" \
-F "repo_url=https://gitlab.example.com/examples/test" \
"http://localhost:3000/api/v1/upload/"
```
where:
* `token` = api_token from config file
* `package` = file to upload (prepend with `@` for `curl`)
* `slack_channel` = slack channel where to post URL to the build page
* `branch` (optional) = branch name
* `commit` (optional) = commit ID
* `repo_url` (optional) = gitlab repo url
