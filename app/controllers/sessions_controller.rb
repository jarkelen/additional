class SessionsController < ApplicationController
	skip_filter :authenticate_user
	
	# Create new session when user logs in
  def create
    if user = User.find_by_email(params[:email])
      if user.authenticate(params[:password])
        reset_session
        session[:user_id] = user.id

        # Update the user stats
        user.update_sign_in_stats

        redirect_to users_dashboard_path, :notice => I18n.t(:session_logged_in)
      else
        flash.now.alert = I18n.t(:session_invalid)
        render "new"
      end
    else
      flash.now.alert = I18n.t(:session_invalid)
      render "new"
    end
  end

	# Destor the session when the user logs out
  def destroy
    session[:user_id] = nil
    redirect_to root_path, :notice => I18n.t(:session_logged_out)
  end

end


