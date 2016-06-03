class ScanEngRunImportsController < ApplicationController
  def new
    @scan_eng_run_import = ScanEngRunImport.new(:scan_eng_run_id => @scan_eng_run_id)
  end

  def create
    @scan_eng_run_import = ScanEngRunImport.new(params[:scan_eng_run_import])
    @scan_eng_run_import.scan_eng_run=ScanEngRun.find(@scan_eng_run_import.scan_eng_run_id)
    if @scan_eng_run_import.save
      redirect_to root_url, notice: "Imported Scan Eng Run Logs successfully."
    else
      render :new
    end
  end

end
