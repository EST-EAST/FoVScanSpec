class Fov < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name   :string
    size_x :float
    size_y :float
    size_z :float
    zero_x :float, :default => nil
    zero_y :float, :default => nil
    zero_z :float, :default => nil
    inverse_x :boolean, :default => false
    inverse_y :boolean, :default => false
    inverse_z :boolean, :default => false
    scans_count :integer, default: 0, null: false
    timestamps
  end
  attr_accessible :name, :size_x, :size_y, :size_z, :scans, :zero_x, :zero_y, :zero_z, :inverse_x, :inverse_y, :inverse_z

  has_many :scans, :dependent => :destroy, :inverse_of => :fov

  def zero
    if (zero_x == nil) then
      centx = size_x / 2
    else
      centx = zero_x
    end
    if (zero_y == nil) then
      centy = size_y / 2
    else
      centy = zero_y
    end
    if (zero_z == nil) then
      centz = size_z / 2
    else
      centz = zero_z
    end
    return centx, centy, centz
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
