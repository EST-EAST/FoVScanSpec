class SweepExesController < ApplicationController

  hobo_model_controller

  public :render

  auto_actions :all

  def show	
    hobo_show do |format|
      format.svg {
        render :inline => find_instance.to_svg
      }
      format.html
      format.py
    end
  end

  def index
	hobo_index do |format|
		format.html
		format.py
	end
  end 
end
