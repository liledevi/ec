module ApplicationHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  def logged_in?
    !current_user.nil?
  end
  
  def current_admin
    @current_admin ||= Admin.find_by(id: session[:admin_id])
  end
  def logged_in_admin?
    !current_admin.nil?
  end
  def authenticated_admin?
    return if logged_in_admin?
    redirect_to sessions_new_admin_path, danger: "管理者としてログインが必要です"
  end
end
