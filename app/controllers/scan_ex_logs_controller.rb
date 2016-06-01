class ScanExLogsController < ApplicationController

  hobo_model_controller

  public :render  
  
  auto_actions :all
  auto_actions_for :scan_eng_run, [:new, :create]

end
