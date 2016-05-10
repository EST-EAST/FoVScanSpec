class SweepExLogsController < ApplicationController

  hobo_model_controller

  public :render  
  
  auto_actions :all
  auto_actions_for :sweep_eng_run, [:new, :create]

end
