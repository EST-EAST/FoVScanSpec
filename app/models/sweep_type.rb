class SweepType < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name        :string
    description :text
    sweeps_count :integer, :default => 0, :null => false
    timestamps
  end
  attr_accessible :name, :description, :sweeps

  has_many :sweeps, :dependent => :destroy, :inverse_of => :sweep_type

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
