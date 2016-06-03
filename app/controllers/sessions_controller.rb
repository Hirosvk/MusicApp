class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
      )

    if user.nil?
      flash[:errors] = "invalid email or password"
      render :new
    elsif user.save
      login!(user)
      redirect_to bands_url
    else
      flash[:errors] = user.errors.full_messages
      render :new
    end

  end

  def destroy
    logout!
    redirect_to bands_url
  end




end
