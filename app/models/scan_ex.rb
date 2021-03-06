require 'nokogiri'

class ScanEx < ActiveRecord::Base

  hobo_model # Don't put anything above this

  ScanDir = HoboFields::Types::EnumString.for(:positive, :negative)
  ScanCoord = HoboFields::Types::EnumString.for(:x_dir, :y_dir)

  fields do
    name             :string
    step_size_x      :float
    step_min_x       :integer
    step_number_x    :integer
    step_dir_x 	     ScanEx::ScanDir
    step_init_x      :float

    step_size_y      :float
    step_min_y       :integer
    step_number_y    :integer
    step_dir_y       ScanEx::ScanDir
    step_init_y      :float

    step_init_coord  ScanEx::ScanCoord
    repetitions      :integer
    scan_eng_runs_count :integer, default:0, null:false
    z_y_exchange     :boolean, :default => false
    timestamps
  end

  attr_accessible :name, :step_size_x, :step_min_x, :step_number_x, :step_dir_x, :step_size_y, :step_min_y, :step_number_y, :step_dir_y, :step_init_coord, :step_init_x, :step_init_y, :repetitions, :scan, :scan_id, :z_y_exchange

  belongs_to :scan, :inverse_of => :scan_exes, :counter_cache => true

  has_many :scan_eng_runs, :dependent => :destroy, :inverse_of => :scan_ex

  children :scan_eng_runs,:scan_eng_runs
  
  def next_step(x,y,c)
    return self.scan.scan_type.next_step(x,y,c,
      step_min_x,step_min_y,
      step_min_x+step_number_x-1,
      step_min_y+step_number_y-1,step_init_coord)
  end

  def overflown?(x,y,c)
    return self.scan.scan_type.overflown?(x,y,c,
      step_min_x,step_min_y,
      step_min_x+step_number_x-1,
      step_min_y+step_number_y-1)
  end
  
  def step_max_x
    step_min_x+step_number_x-1
  end
  
  def step_max_y
    step_min_y+step_number_y-1
  end
  
  def window_size
    if (step_dir_x==:positive) then
      minx=step_init_x-(step_size_x*(-step_min_x))-(scan.window.size_x/2)
      maxx=step_init_x+(step_size_x*(step_max_x))+(scan.window.size_x/2)
    else
      maxx=step_init_x+(step_size_x*(-step_min_x))+(scan.window.size_x/2)
      minx=step_init_x-(step_size_x*(step_max_x))-(scan.window.size_x/2)
    end
    if (step_dir_y==:positive) then
      miny=step_init_y-(step_size_y*(-step_min_y))-(scan.window.size_y/2)
      maxy=step_init_y+(step_size_y*(step_max_y))+(scan.window.size_y/2)
    else
      maxy=step_init_y+(step_size_y*(-step_min_y))+(scan.window.size_y/2)
      miny=step_init_y-(step_size_y*(step_max_y))-(scan.window.size_y/2)
    end
    return minx,maxx,miny,maxy
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
    zerox,zeroy,zeroz = scan.fov.zero
    ret = []
    slist.each { |s|  
      step_x = s[:x]
      step_y = s[:y]
      step_counter = s[:c]
      if (self.z_y_exchange) then
        ret << {:x => step_x, :y => step_y, :c => step_counter, 
          :x_coord => (step_init_x+(step_x*step_size_x)),
          :y_coord => (zeroy),
          :z_coord => (step_init_y+(step_y*step_size_y))
        }
      else
        ret << {:x => step_x, :y => step_y, :c => step_counter, 
          :x_coord => (step_init_x+(step_x*step_size_x)),
          :y_coord => (step_init_y+(step_y*step_size_y)),
          :z_coord => (zeroz)
        }
      end
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
        s[:y_coord].to_s+","+
        s[:z_coord].to_s+"]\n"    
    }
    return ret
  end
  
  def step_list_py
    slist = step_coords_list
    ret = ""
    self.repetitions.times do |i|
      slist.each { |s|
        ret+="{ 'i': ("+i.to_s+"),"
        ret+="'c': ("+s[:c].to_s+"),"
        ret+="'x': ("+s[:x].to_s+"),"
        ret+="'y': ("+s[:y].to_s+"),"
        ret+="'x_coord': ("+s[:x_coord].to_s+"),"
        ret+="'y_coord': ("+s[:y_coord].to_s+"),"
        ret+="'z_coord': ("+s[:z_coord].to_s+") },"    
      }
    end
    return ret
  end
  
  def to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ['step','x','y','x_coord','y_coord', 'z_coord']
      step_coords_list.each{ |step|
        csv << [step[:c],step[:x],step[:y],step[:x_coord],step[:y_coord],step[:z_coord]]
      }
    end
  end
  
  
  def to_svg

  end
  
  def to_svg
    # Prepare the values to draw
    if self.z_y_exchange then
      scale=80.0*(1.0/[scan.fov.size_x,scan.fov.size_z].min)
    else
      scale=80.0*(1.0/[scan.fov.size_x,scan.fov.size_y].min)
    end
    
    zerox,zeroy,zeroz = scan.fov.zero
    zerox *= scale
    zeroy *= scale
    zeroz *= scale
    
    x=scan.fov.size_x * scale
    y=scan.fov.size_y * scale
    z=scan.fov.size_z * scale

    winx=scan.window.size_x * scale
    winy=scan.window.size_y * scale

    initx=step_init_x * scale
    inity=step_init_y * (-scale)
    
    stepx=self.step_size_x * scale
    stepy=self.step_size_y * scale

    if (scan.fov.inverse_x) then
      zerox=-zerox
      initx=-initx
      stepx=-stepx
    end
    if (scan.fov.inverse_y) then
      zeroy=-zeroy
      inity=-inity
      stepy=-stepy
    end
    if (scan.fov.inverse_z) then
      zeroz=-zeroz
      initz=-initz
      stepz=-stepz
    end
    
    if self.z_y_exchange==true then
      y = z
      zeroy = zeroz
    end
    
    # Create the XML tree
    b = Nokogiri::XML::Builder.new do |doc|
      box=(-zerox).to_s+" "+(-zeroy).to_s+" "+((x)*1.5).to_s+" "+((y)*1.5).to_s
      doc.svg xmlns:"http://www.w3.org/2000/svg", viewBox:box do
        # Draw a reticle with red lines
        dm="m "+(-zerox).to_s+" 0 h "+x.to_s
        streticle="stroke:red;stroke-width:0.1"
        doc.path d:dm, id:"Xaxis", style:streticle
        dm="m 0 "+(-zeroy).to_s+" v "+y.to_s
        doc.path d:dm, id:"Yaxis", style:streticle
        # Print the FoV
        stfov="opacity:0.18300003;fill:#abc9ff;fill-opacity:1;stroke:#000000;stroke-width:0.55699998;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
        doc.rect x:(-zerox), y:(-zeroy), width:x, height:y, style:stfov, id:"fov"
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
            doc.rect x:(x_coord*scale-winx/2), y:(y_coord*(-scale)-winy/2), width:winx, height:winy, style:stfov, id:"win"
            doc.text_ id:"label", x:((x_coord*scale)-winx/10), y:((y_coord*(-scale))+winy/4), style:stlabel do
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
