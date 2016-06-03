class ScanEngRunImportsController < ApplicationController

class ProjectFlowsImportsController < ApplicationController
  def new
    @scan_eng_run_import = ScanEngRunImport.new(:scan_ex_id => @scan_ex_id)
  end

  def create
=begin    
    @scan_eng_run_import = ProjectFlowsImport.new(params[:project_flows_import])
    @scan_eng_run_import.project=Project.find(@project_flows_import.project_id)
    if @project_flows_import.save
      redirect_to root_url, notice: "Imported project flows successfully."
    else
      render :new
    end
=end
  end

end
