class SweepExLog < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    step :integer
    x :integer
    y :integer
    x_coord :float
    y_coord :float
    m1 :float
    m2 :float
    m3 :float
    timestr :string
    dtinit :datetime
    dtend :datetime
    m1_fdback :float
    m2_fdback :float
    m3_fdback :float
    timestamps
  end
  attr_accessible :step, :x, :y, :x_coord, :y_coord, :m1, :m2, :m3, :m1_fdback, :m2_fdback, :m3_fdback, :timestr, :dtinit, :dtend, :sweep_eng_run, :sweep_eng_run_id

  belongs_to :sweep_eng_run, :inverse_of => :sweep_ex_logs, :counter_cache => true
  
  
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
