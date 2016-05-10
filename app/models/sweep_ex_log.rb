class SweepExLog < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    a :float
    b :float
    c :float
    timestamps
  end
  attr_accessible :a, :b, :c, :sweep_eng_run, :sweep_eng_run_id

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
