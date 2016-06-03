class ScanEngRun < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name         :string
    max_l1_speed :float
    max_l2_speed :float
    max_l3_speed :float
    
    timestamps
  end
  attr_accessible :name, :max_l1_speed, :max_l2_speed, :max_l3_speed, :scan_ex, :scan_ex_id

  belongs_to :scan_ex, :inverse_of => :scan_eng_runs
  has_many :scan_ex_logs, :dependent => :destroy, :inverse_of => :scan_eng_run

  children :scan_ex_logs
  
  def total_time
    sum=0
    scan_ex_logs.each {|exlog|
      sum+=exlog.deltatime
    }
    return sum
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
