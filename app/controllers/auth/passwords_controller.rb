class Auth::PasswordsController < Devise::PasswordsController
  def new
    flash[:info] = 'Registrations are not open.'
    redirect_to root_path
  end

  def create
    flash[:info] = 'Registrations are not open.'
    redirect_to root_path
  end

  def edit
    flash[:info] = 'Registrations are not open.'
    redirect_to root_path
  end

  def update
    flash[:info] = 'Registrations are not open.'
    redirect_to root_path
  end
end