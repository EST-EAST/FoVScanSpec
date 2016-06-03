class ScanEngRunImportsController < ApplicationController
  def new
    @scan_eng_run_import = ScanEngRunImport.new()
  end

  def create
    @scan_eng_run_import = ScanEngRunImport.new(params[:scan_eng_run_import])
    if @scan_eng_run_import.save
      redirect_to root_url, notice: "Imported Scan Eng Run Logs successfully."
    else
      render :new
    end
  end

end
