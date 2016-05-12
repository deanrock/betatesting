class BuildsController < ApplicationController
  before_action :set_build, only: [:show, :update, :destroy]

  def welcome_public

  end

  # GET /b/:key
  def show_public
    @build = Build.find_by_key!(params[:key])

    @mobile = mobile_device?
  end

  # GET /b/:key/manifest.plist
  def manifest_public
    @build = Build.find_by_key!(params[:key])

    render :layout => false
  end

  # GET /b/:key/app.ipa
  def app_public
    @build = Build.find_by_key!(params[:key])
    send_file @build.package.path, :type => @build.package_content_type, :disposition => 'inline'
  end

  # GET /builds
  # GET /builds.json
  def index
    @builds = Build.all
  end

  # GET /builds/1
  # GET /builds/1.json
  def show
    redirect_to action: 'show_public', key: @build.key
  end

  # GET /builds/1/reimport
  def reimport
    @build = Build.find_by_id(params[:id])
    @build.import
    redirect_to @build
  end

  # GET /builds/new
  def new
    @build = Build.new
  end

  # POST /builds
  # POST /builds.json
  def create
    @build = Build.new(build_params)

    respond_to do |format|
      if @build.save

        if @build.import
          format.html { redirect_to @build, notice: 'Build was successfully created.' }
          format.json { render :show, status: :created, location: @build }
        else
          @build.delete
          format.html { render :new, notice: 'Error while importing.' }
          format.json { render json: { 'error': 'Error while importing.' }, status: :unprocessable_entity }
        end
      else
        format.html { render :new }
        format.json { render json: @build.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /builds/1
  # DELETE /builds/1.json
  def destroy
    @build.destroy
    respond_to do |format|
      format.html { redirect_to builds_url, notice: 'Build was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_build
      @build = Build.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def build_params
      params.require(:build).permit(:package)
    end
end
