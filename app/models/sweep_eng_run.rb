class SweepEngRun < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name         :string
    max_l1_speed :float
    max_l2_speed :float
    max_l3_speed :float
    timestamps
  end
  attr_accessible :name, :max_l1_speed, :max_l2_speed, :max_l3_speed, :sweep_ex, :sweep_ex_id

  belongs_to :sweep_ex, :inverse_of => :sweep_eng_runs, :counter_cache => true

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
