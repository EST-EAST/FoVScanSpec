class ScanExLog < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    iteration :integer, default:0
    step :integer
    step_order :integer # if not present, must be equal to step, so special migration has been added
    x :integer
    y :integer
    x_coord :float
    y_coord :float
    mx :float
    my :float
    mcomp :float
    timestr :string
    dtinit :datetime
    dtend :datetime
    mx_fdback :float
    my_fdback :float
    mcomp_fdback :float
    timestamps
  end
  attr_accessible :step_order, :iteration, :step, :x, :y, :x_coord, :y_coord, :mx, :my, :mcomp, :mx_fdback, :my_fdback, :mcomp_fdback, :timestr, :dtinit, :dtend, :scan_eng_run, :scan_eng_run_id

  belongs_to :scan_eng_run, :inverse_of => :scan_ex_logs
  
  def self.import_attributes
    ret=ScanExLog.accessible_attributes.clone
    #ret.delete("scan_eng_run_id")
    #ret.delete("scan_eng_run")
    #ret.delete("flow_type")
    ret.delete("")
    return ret
  end
  
  def deltatime
    dtend-dtinit
  end
  
  def title
    #""+step_order.to_s+iteration.to_s+":"+step.to_s+": x:"+x_coord.to_s+" y:"+y_coord.to_s+" m1:"+mx_fdback.to_s+" m2:"+my_fdback.to_s+" m3:"+mcomp_fdback.to_s+" time:"+deltatime.to_s
    step_order.to_s+":"+iteration.to_s+":"+step.to_s
  end
  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator? or true
  end

  def update_permitted?
    acting_user.administrator? or true
  end

  def destroy_permitted?
    acting_user.administrator? or true
  end

  def view_permitted?(field)
    true
  end

end
