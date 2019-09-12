class AdminsController < ApplicationController
  def create
    Admin.create(admin_params)
  end
  
  def edit
    @admin = Admin.find(params[:id])
  end
  
  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy
  end
  
  private
  def admin_params
    params.require(:admin).permit(:name, :emai, :password,:password_confirmation)
  end
end
