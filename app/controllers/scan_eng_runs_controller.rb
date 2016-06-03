class ScanEngRunsController < ApplicationController
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

    hobo_model_controller

    public :render

    auto_actions :all

    def show
      hobo_show do |format|
        format.html
        format.tsv { send_data @scan_eng_run.to_csv(col_sep: "\t")  }
      end
    end     
    
    def json_request?
      # request.format.json?
      true
    end
  end
