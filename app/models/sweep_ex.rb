require 'nokogiri'

class SweepEx < ActiveRecord::Base

  hobo_model # Don't put anything above this

  SweepDir = HoboFields::Types::EnumString.for(:positive, :negative)
  SweepCoord = HoboFields::Types::EnumString.for(:x_dir, :y_dir)

  fields do
    name             :string
    step_size_x      :float
    step_number_x    :float
    step_dir_x 	     SweepEx::SweepDir
    step_size_y      :float
    step_number_y    :float
    step_dir_y       SweepEx::SweepDir
    step_init_coord  SweepEx::SweepCoord
    step_init_x      :float
    step_init_y      :float
    repetitions      :integer
    sweep_eng_runs_count :integer, :default => 0, :null => false
    timestamps
  end

  attr_accessible :name, :step_size_x, :step_number_x, :step_dir_x, :step_size_y, :step_number_y, :step_dir_y, :step_init_coord, :step_init_x, :step_init_y, :repetitions, :sweep, :sweep_id

  belongs_to :sweep, :inverse_of => :sweep_exes, :counter_cache => true

  has_many :sweep_eng_runs, :dependent => :destroy, :inverse_of => :sweep_ex

  def nextStep(x,y,c)
    # Step sequence index determination 
    c+=1
    case sweep.sweep_type.name
    when "Spiral"
      x+=1
      if (x>=4) then
	x=0
	y+=1
      end
    end
    return x,y,c
  end

  def endStep(x,y,c)
    return (y>=4)
  end

  def initialStep()
    return 0,0,0
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

        stepX,stepY,stepCounter=initialStep()
	while not(endStep(stepX,stepY,stepCounter)) do
	  stepX,stepY,stepCounter=nextStep(stepX,stepY,stepCounter)

          doc.g id:"step"+stepX.to_s+"_"+stepY.to_s do
	    doc.rect x:(initx-winx/2+(stepX*winx)), y:(inity-winy/2+(stepY*winy)), width:winx, height:winy, style:stfov, id:"win"
            doc.text_ id:"label", x:(initx+(stepX*winx)-winy/2), y:(inity+(stepY*winy)+winy/4), style:stlabel do
#              doc.tspan stepX.to_s+","+stepY.to_s
               doc.tspan stepCounter.to_s
            end
          end

	end
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
