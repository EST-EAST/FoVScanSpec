class Admin::AdminSiteController < ApplicationController

  hobo_controller

  public :render  
  
  before_filter :admin_required

  private

  def admin_required
    redirect_to home_page unless current_user.administrator?
  end

end