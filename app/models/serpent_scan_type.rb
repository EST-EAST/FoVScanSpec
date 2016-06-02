class SerpentScanType < ScanType

  def name
    "Serpent"
  end


  def next_step(x,y,c,minx,miny,maxx,maxy,initdir)
    nc=c+1
    if (initdir!=:y_dir) then
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
    else
      if (((x-minx) % 2) == 0) then
        ny=y+1
        if (ny>maxy) then
          ny=maxy
          nx=x+1
        else
          nx=x
        end
      else
        ny=y-1
        if (ny<miny) then
          ny=miny
          nx=x+1
        else
          nx=x
        end
      end
    end
    x=nx
    y=ny
    c=nc
    return x,y,c
  end  
end
