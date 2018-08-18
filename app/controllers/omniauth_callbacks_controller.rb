class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # for Facebook login
  def facebook
    @user = User.find_for_facebook_oauth(
      request.env['omniauth.auth']
    )

    user_sign_in(@user, 'facebook_data')
  end

  # for Google login
  def google_oauth2
    @user = User.find_for_google_oauth2(
      request.env['omniauth.auth']
    )
    user_sign_in(@user, 'google_data')
  end

  def user_sign_in(user, provider_data)
    if user.persisted?
      session[:sn_user] = request.env['omniauth.params']
      sign_in_and_redirect user, event: :authentication
    else
      session["devise.#{provider_data}"] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end
end
