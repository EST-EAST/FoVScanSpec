class ScanEngRunImport 
  # switch to ActiveModel::Model in Rails 4
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :file, :scan_eng_run_id, :scan_eng_run

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def save
    imported_scan_eng_runs
    true
  end

  def imported_scan_eng_runs
    @imported_scan_eng_runs ||= load_imported_scan_eng_runs
  end

  def imported_scan_eng_runs
    spreadsheet = open_spreadsheet

    # Recurrence Times
    ucanca_sheet=spreadsheet.sheet('EngRun')
    header = ucanca_sheet.row(1)
    (2..ucanca_sheet.last_row).map do |i|
=begin      
      row = Hash[[header, ucanca_sheet.row(i)].transpose]
      if (row["name"]!=nil && row["name"]!="")
        conv = scan_eng_run.datum_conversions.find_by_name(row["name"]) || scan_eng_run.datum_conversions.find_by_name(row["old_name"]) || DatumConversion.new
        conv.attributes = row.to_hash.slice(*DatumConversion.import_attributes)
        conv.scan_eng_run=self.scan_eng_run
        ftype=FlowType.find_by_name(row["flow_type"])
        print "\nrow:"+row["flow_type"]
        conv.flow_type=ftype        

        print "\Importamos: "+conv.attributes.to_s
        if (conv.valid?)
          conv.save!
          conv
        else
          conv.errors.full_messages.each do |message|
            errors.add :base, "Row #{i+2}: #{message}"
          end
          nil
        end
        # Let's see if we have to create a subsystem
      else
        nil
      end
=end    
    end


    ucanca_sheet=spreadsheet.sheet('ExLog')
    header = ucanca_sheet.row(1)
    (2..ucanca_sheet.last_row).map do |i|
      print "\ntrato "+i.to_s
      row = Hash[[header, ucanca_sheet.row(i)].transpose]
      if (row["step"]!=nil && row["step"]!="")
        exlog = scan_eng_run.scan_ex_logs.find_by_id(row["step"]) || ScanExLog.new
        exlog.attributes = row.to_hash.slice(*ScanExLog.import_attributes)
        exlog.step=row["step"]
        exlog.scan_eng_run_id=self.scan_eng_run_id
        print "\nImportamos: "+exlog.attributes.to_s
        if (exlog.valid?)
          exlog.save!
          exlog
        else
          exlog.errors.full_messages.each do |message|
            errors.add :base, "Row #{i+2}: #{message}"
          end
          nil
        end
        # Let's see if we have to create a subsystem
      else
        nil
      end
    end
  end

  def open_spreadsheet
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path,{:file_warning => :ignore})
    when ".xls" then Roo::Excel.new(file.path,{:file_warning => :ignore})
    when ".xlsx" then Roo::Excelx.new(file.path,{:file_warning => :ignore})
    when ".ods" then Roo::OpenOffice.new(file.path,{:file_warning => :ignore})
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

end
