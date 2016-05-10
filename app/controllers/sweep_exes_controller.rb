class SweepExesController < ApplicationController

  hobo_model_controller

  public :render

  auto_actions :all

  def show	
    @sweep_ex=find_instance
    respond_to do |format|
      format.svg {
        render :inline => find_instance.to_svg
      }
=begin
    format.py {
      render :inline => find_instance.to_py
    }
=end    
      format.html
      format.py
    end
  end
  
end
