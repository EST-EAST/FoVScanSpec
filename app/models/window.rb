class Window < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name   :string
    size_x :float
    size_y :float
    sweeps_count :integer, :default => 0, :null => false
    timestamps
  end
  attr_accessible :name, :size_x, :size_y, :sweeps

  has_many :sweeps, :dependent => :destroy, :inverse_of => :window

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
