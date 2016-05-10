require 'nokogiri'

class SweepEx < ActiveRecord::Base

  hobo_model # Don't put anything above this

  SweepDir = HoboFields::Types::EnumString.for(:positive, :negative)
  SweepCoord = HoboFields::Types::EnumString.for(:x_dir, :y_dir)

  fields do
    name             :string
    step_size_x      :float
    step_min_x       :integer
    step_number_x    :integer
    step_dir_x 	     SweepEx::SweepDir
    step_init_x      :float

    step_size_y      :float
    step_min_y       :integer
    step_number_y    :integer
    step_dir_y       SweepEx::SweepDir
    step_init_y      :float

    step_init_coord  SweepEx::SweepCoord
    repetitions      :integer
    sweep_eng_runs_count :integer, :default => 0, :null => false
    timestamps
  end

  attr_accessible :name, :step_size_x, :step_min_x, :step_number_x, :step_dir_x, :step_size_y, :step_min_y, :step_number_y, :step_dir_y, :step_init_coord, :step_init_x, :step_init_y, :repetitions, :sweep, :sweep_id

  belongs_to :sweep, :inverse_of => :sweep_exes, :counter_cache => true

  has_many :sweep_eng_runs, :dependent => :destroy, :inverse_of => :sweep_ex

  def next_step(x,y,c)
    return self.sweep.sweep_type.next_step(x,y,c,
      step_min_x,step_min_y,
      step_min_x+step_number_x-1,
      step_min_y+step_number_y-1)
  end

  def overflown?(x,y,c)
    return self.sweep.sweep_type.overflown?(x,y,c,
      step_min_x,step_min_y,
      step_min_x+step_number_x-1,
      step_min_y+step_number_y-1)
  end
  
  def initial_step
    return 0,0,0
  end

  def step_list
    # Prepare the values to draw

    step_x,step_y,step_counter=initial_step()
    ret = []
    while not(overflown?(step_x,step_y,step_counter)) do
      if (step_dir_x==:positive) then
        step_x_final = step_x
      else
        step_x_final = -step_x
      end
      if (step_dir_y==:positive) then
        step_y_final = step_y
      else
        step_y_final = -step_y
      end      
      ret << { :x => step_x_final, :y => step_y_final, :c => step_counter}
      step_x,step_y,step_counter=next_step(step_x,step_y,step_counter)
    end
    return ret    
  end
  
  def step_coords_list
    slist = step_list
    ret = []
    slist.each { |s|  
      step_x = s[:x]
      step_y = s[:y]
      step_counter = s[:c]
      ret << {:x => step_x, :y => step_y, :c => step_counter, 
        :x_coord => (step_init_x+(step_x*step_size_x)),
        :y_coord => (step_init_y+(step_y*step_size_y))
      }
    }
    return ret
  end
  
  def step_list_text
    slist = step_coords_list
    ret = ""
    slist.each { |s|
          ret+=s[:c].to_s+": ["+
            s[:x].to_s+","+
            s[:y].to_s+"] -> ["+
            s[:x_coord].to_s+","+
            s[:y_coord].to_s+"]\n"    
    }
    return ret
  end
  
  def step_list_py
    slist = step_coords_list
    ret = ""
    slist.each { |s|
          ret+="{ 'c': ("+s[:c].to_s+"),"
          ret+="'x': ("+s[:x].to_s+"),"
          ret+="'y': ("+s[:y].to_s+"),"
          ret+="'x_coord': ("+s[:x_coord].to_s+"),"
          ret+="'y_coord': ("+s[:y_coord].to_s+") },"    
    }
    return ret
  end
  
  def to_svg

  end
  
  def to_svg
    # Prepare the values to draw
    scale=5000
    x=sweep.fov.size_x * scale
    y=sweep.fov.size_y * scale

    winx=sweep.window.size_x * scale
    winy=sweep.window.size_y * scale

    initx=step_init_x * scale
    inity=step_init_y * scale
    
    stepx=self.step_size_x * scale
    stepy=self.step_size_y * scale

    # Create the XML tree
    b = Nokogiri::XML::Builder.new do |doc|
      box=(-(x/2)).to_s+" "+(-(y/2)).to_s+" "+(x*1.1).to_s+" "+(y*1.1).to_s
      doc.svg xmlns:"http://www.w3.org/2000/svg", viewBox:box do
        # Draw a reticle with red lines
        dm="m "+(-x/2).to_s+" 0 h "+x.to_s
        streticle="stroke:red;stroke-width:0.1"
        doc.path d:dm, id:"Xaxis", style:streticle
        dm="m 0 "+(-y/2).to_s+" v "+y.to_s
        doc.path d:dm, id:"Yaxis", style:streticle
        # Print the FoV
        stfov="opacity:0.18300003;fill:#abc9ff;fill-opacity:1;stroke:#000000;stroke-width:0.55699998;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
        doc.rect x:(-x/2), y:(-y/2), width:x, height:y, style:stfov, id:"fov"
        # Print the window
        doc.rect x:(-winx/2), y:(-winy/2), width:winx, height:winy, style:stfov, id:"window"

        # Print the initial position
        stfov="opacity:0.18300003;fill:#abc9ff;fill-opacity:1;stroke:blue;stroke-width:0.1;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
        doc.rect x:(initx-winx/2), y:(inity-winy/2), width:winx, height:winy, style:stfov, id:"window_init"

        stlabel="font-style:normal;font-weight:normal;font-size:2px;line-height:125%;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"

        slist = step_coords_list
        slist.each { |s|  
          step_x = s[:x]
          step_y = s[:y]
          step_counter = s[:c]
          x_coord = s[:x_coord]
          y_coord = s[:y_coord]

          doc.g id:"step"+step_x.to_s+"_"+step_y.to_s do
            doc.rect x:(x_coord*scale-winx/2), y:(y_coord*scale-winy/2), width:winx, height:winy, style:stfov, id:"win"
            doc.text_ id:"label", x:((x_coord*scale)-winx/10), y:((y_coord*scale)+winy/4), style:stlabel do
              doc.tspan step_counter.to_s
            end
          end
        }
      end
    end
    return b.to_xml
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
