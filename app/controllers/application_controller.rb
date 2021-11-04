class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # 管理者ロウグアウト後は管理者ログインページ、
  # ユーザーログアウト後はトップページへ飛ぶ
  def after_sign_out_path_for(resource)
    if resource == :admin
      new_admin_session_path
    else
      root_path
    end
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :profile_image_id, :introduction, :age, :skin_type, :is_deleted])
  end

end
