class SweepEngRunsController < ApplicationController
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

  hobo_model_controller

  public :render

  auto_actions :all

  def json_request?
      # request.format.json?
      true
  end
end
