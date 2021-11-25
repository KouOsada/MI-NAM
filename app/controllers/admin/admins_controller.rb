class Admin::AdminsController < ApplicationController
  
  def edit
    @admin = Admin.find(params[:id])
  end
  
  def update
    @admin = Admin.find(params[:id])
    @admin.update(admin_params)
    redirect_to admin_users_path
  end
  
  private
  def admin_params
    params.require(:admin).permit(:email, :password)
  end
  
end
