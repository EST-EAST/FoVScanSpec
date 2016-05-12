class SweepExLog < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    step :integer
    x :integer
    y :integer
    x_coord :float
    y_coord :float
    a :float
    b :float
    c :float
    timestr :string
    dtinit :datetime
    dtend :datetime
    timestamps
  end
  attr_accessible :step, :x, :y, :x_coord, :y_coord, :a, :b, :c, :timestr, :dtinit, :dtend, :sweep_eng_run, :sweep_eng_run_id

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
