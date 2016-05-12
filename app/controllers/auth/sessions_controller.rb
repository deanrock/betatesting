class Auth::SessionsController < Devise::SessionsController
  def new
    redirect_to '/users/auth/gitlab'
  end

  def create
    flash[:info] = 'Registrations are not open.'
    redirect_to root_path
  end
end