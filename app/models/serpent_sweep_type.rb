class SerpentSweepType < SweepType

  def name
    "Serpent"
  end


  def next_step(x,y,c,minx,miny,maxx,maxy)
    nc=c+1
    if (((y-miny) % 2) == 0) then
      nx=x+1
      if (nx>maxx) then
        nx=maxx
        ny=y+1
      else
        ny=y
      end
    else
      nx=x-1
      if (nx<minx) then
        nx=minx
        ny=y+1
      else
        ny=y
      end
    end
    x=nx
    y=ny
    c=nc
    return x,y,c
  end  
end
