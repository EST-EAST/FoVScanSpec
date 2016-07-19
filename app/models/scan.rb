class Scan < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    double_sampling :boolean
    scan_exes_count :integer, default:0, null:false
    timestamps
  end
  attr_accessible :double_sampling, :fov, :fov_id, :window, :window_id, :scan_type, :scan_type_id

  belongs_to :fov, :inverse_of => :scans, :counter_cache => true
  belongs_to :window, :inverse_of => :scans, :counter_cache => true
  belongs_to :scan_type, :inverse_of => :scans, :counter_cache => true

  has_many :scan_exes, :dependent => :destroy, :inverse_of => :scan

  # --- Calculated attributes --- #

  def name
	ret=fov.name+":"+window.name+":"+scan_type.name
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
