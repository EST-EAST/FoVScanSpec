class ScanType < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name        :string
    description :text
    scans_count :integer, default:0, null:false
    type        :string
    timestamps
  end
  attr_accessible :name, :description, :scans, :type

  has_many :scans, :dependent => :destroy, :inverse_of => :scan_type

  def next_step(x,y,c,minx,miny,maxx,maxy,initdir)
    nc=c+1
    if (initdir!=:y_dir) then
      nx=x+1
      if (nx>maxx) then
        nx=minx
        ny=y+1
      else
        ny=y
      end
    else
      ny=y+1
      if (ny>maxy) then
        ny=miny
        nx=x+1
      else
        nx=x
      end      
    end
    x=nx
    y=ny
    c=nc
    return x,y,c
  end

  def overflown?(x,y,c,minx,miny,maxx,maxy)
    return (x>maxx or x<minx or y>maxy or y<miny)
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
