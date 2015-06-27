class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  

  def facebook
    
    user = User.from_omniauth(request.env["omniauth.auth"], current_user)
    binding.pry
    provider = env["omniauth.auth"].provider

    if user.persisted?
      sign_in_and_redirect user, event: :authentication
    else
      session["devise.#{provider}_data"] = env["omniauth.auth"]
      redirect_to new_user_registration_url
    end


  end
  

end
