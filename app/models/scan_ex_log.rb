class ScanExLog < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    step :integer
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
  attr_accessible :step, :x, :y, :x_coord, :y_coord, :mx, :my, :mcomp, :mx_fdback, :my_fdback, :mcomp_fdback, :timestr, :dtinit, :dtend, :scan_eng_run, :scan_eng_run_id

  belongs_to :scan_eng_run, :inverse_of => :scan_ex_logs
  
  
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
