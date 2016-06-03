class ScanEngRun < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name          :string
    use_cam       :boolean
    stab_time     :float
    use_sim       :boolean
    proto_rev     :integer
    ls1_va        :float
    ls2_va        :float
    ls3_va        :float
    ls1_vh        :float
    ls2_vh        :float
    ls3_vh        :float
    ls1_vi        :float
    ls2_vi        :float
    ls3_vi        :float
    ls1_scale     :float
    ls2_scale     :float
    ls3_scale     :float
    ls1_min       :integer
    ls2_min       :integer
    ls3_min       :integer
    ls1_max       :integer
    ls2_max       :integer
    ls3_max       :integer
    ls1_zero       :integer
    ls2_zero       :integer
    ls3_zero       :integer
    
    timestamps
  end
  attr_accessible :name, :max_l1_speed, :max_l2_speed, :max_l3_speed, :scan_ex, 
    :scan_ex_id, :use_cam, :stab_time, :use_sim, :proto_rev, :ls1_va, :ls2_va, 
    :ls3_va, :ls1_vh, :ls2_vh, :ls3_vh, :ls1_vi, :ls2_vi, 
    :ls3_vi, :ls1_scale, :ls2_scale, :ls3_scale, :ls1_min, 
    :ls2_min, :ls3_min, :ls1_max, :ls2_max, :ls3_max, :ls1_zero, :ls2_zero, 
    :ls3_zero

  belongs_to :scan_ex, :inverse_of => :scan_eng_runs
  has_many :scan_ex_logs, :dependent => :destroy, :inverse_of => :scan_eng_run

  children :scan_ex_logs
  
  
  def steps_vs_time
    data = []
    scan_ex_logs.each {|exlog|
      data << [exlog.step,exlog.deltatime]
    }
    return data
  end
  
  def to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ScanExLog.column_names
      scan_ex_logs.each do |exlog|
        csv << exlog.attributes.values_at(*ScanExLog.column_names)
      end
    end
  end
  
  def total_time
    sum=0
    scan_ex_logs.each {|exlog|
      sum+=exlog.deltatime
    }
    return sum
  end
  
  def self.import_attributes
    ret=ScanEngRun.accessible_attributes.clone
    #ret.delete("scan_eng_run_id")
    #ret.delete("scan_eng_run")
    #ret.delete("flow_type")
    ret.delete("")
    return ret
  end  
  
  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

end
