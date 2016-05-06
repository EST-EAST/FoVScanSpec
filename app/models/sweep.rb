class Sweep < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    double_sampling :boolean
    sweep_exes_count :integer, :default => 0, :null => false
    timestamps
  end
  attr_accessible :double_sampling, :fov, :fov_id, :window, :window_id, :sweep_type, :sweep_type_id

  belongs_to :fov, :inverse_of => :sweeps, :counter_cache => true
  belongs_to :window, :inverse_of => :sweeps, :counter_cache => true
  belongs_to :sweep_type, :inverse_of => :sweeps, :counter_cache => true

  has_many :sweep_exes, :dependent => :destroy, :inverse_of => :sweep

  # --- Calculated attributes --- #

  def name
	ret=fov.name+":"+window.name+":"+sweep_type.name
	if double_sampling then
		ret+=":d"
	end
	return ret
  end

  def steps_x
	ret=fov.size_x/window.size_x
  end

  def steps_y
        ret=fov.size_y/window.size_y
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
