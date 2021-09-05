class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  

  
  private
#ログイン後userの詳細画面に遷移
  def after_sign_in_path_for(resource)
     user_path(current_user)
  end
#登録後userの詳細画面に遷移
  def after_sign_up_path_for(resource)
    user_path(current_user)
  end
#emailの送信を許可
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
  def after_sign_out_path_for(resource)
    root_path
  end
end 
