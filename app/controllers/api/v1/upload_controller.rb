class Api::V1::UploadController < Api::V1::BaseController
  before_action :authenticate_api!, :only => [:upload]

  def upload
    puts(params)

    @build = Build.new(:package => params[:package])

    @build.branch = params[:branch]
    @build.commit = params[:commit]
    @build.repo_url = params[:repo_url]

    if @build.save

      if @build.import
        # continue
      else
        @build.delete
        return render json: { 'error': 'Error while importing.' }
      end

    else
      return render json: @build.errors, status: :unprocessable_entity
    end

    @url = request.base_url + '/b/' + @build.key

    if params[:slack_channel]
      client = Slack::Web::Client.new
      client.chat_postMessage(channel: params[:slack_channel], text: 'Build *' + @build.version + ' (' + @build.build + ')* for *' + @build.app.name + ' [' + @build.app.platform + ']* is available at: ' + @url, username: 'Build Bot')
    end

    render :json => { :status => 'OK', :url => @url }
  end
end