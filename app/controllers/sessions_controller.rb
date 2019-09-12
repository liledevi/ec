class SessionsController < ApplicationController
  def new_admin
  end
  
  def create_admin
    admin = Admin.find_by(email_params)
    if admin && admin.authenticate(password_params[:password])
      log_in_admin admin
      redirect_to admins_root_path, success: '管理者ログインに成功しました！'
    else
      flash.now[:danger] = '管理者ログインに失敗しました><'
      render :new
    end
  end
  
  def destroy_admin
    log_out_admin
    redirect_to root_url, info: '管理者ログアウトしました'
  end
  
  def new
  end
  
  def create
    user = User.find_by(email_params)
    if user && user.authenticate(password_params[:password])
      log_in user
      exist_cart = Cart.find_by(user_id: current_user.id)
      if !exist_cart
        Cart.create(user_id: current_user.id)
      end
      redirect_to root_path, success: 'ログインに成功しました！'
    else
      flash.now[:danger] = 'ログインに失敗しました><'
      render :new
    end
  end
  
  def destroy
    log_out
    redirect_to root_url, info: 'ログアウトしました'
  end

  private
  def email_params
    params.require(:session).permit(:email)
  end
  def password_params
    params.require(:session).permit(:password)
  end
  
  def log_in(user)
    session[:user_id] = user.id
  end
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  def log_in_admin(admin)
    session[:admin_id] = admin.id
  end
  def log_out_admin
    session.delete(:admin_id)
    @current_admin = nil
  end
end

