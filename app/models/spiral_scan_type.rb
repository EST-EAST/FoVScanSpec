class SpiralScanType < ScanType

  SPIRAL_DIR_X_POS = 0
  SPIRAL_DIR_Y_POS = 1
  SPIRAL_DIR_X_NEG = 2
  SPIRAL_DIR_Y_NEG = 3

  @direction=SPIRAL_DIR_X_POS
  @overflown=false

  def next_spiral_dir(d)
    if (d==SPIRAL_DIR_X_POS) then
      return SPIRAL_DIR_Y_POS
    end
    if (d==SPIRAL_DIR_Y_POS) then
      return SPIRAL_DIR_X_NEG
    end
    if (d==SPIRAL_DIR_X_NEG) then
      return SPIRAL_DIR_Y_NEG
    end
    if (d==SPIRAL_DIR_Y_NEG) then
      return SPIRAL_DIR_X_POS
    end
  end
  
  def name
    "Spiral"
  end

  def init_table(x,y,c,minx,miny,maxx,maxy)
    @table=[]
    cx=0
    while cx<=(maxx-minx) do
      cy=0
      t=[]
      while cy<=(maxy-miny) do
        t[cy]=false
        cy+=1
      end
      @table[cx]=t
      cx+=1
    end
 #   print "Tabla: "+@table.to_s+"\n\n"
  end

  def next_step_dir(x,y,tempt_dir)
      print "la tentativa a probar es "+tempt_dir.to_s+"\n"

      if (tempt_dir==SPIRAL_DIR_X_POS) then
            print "Entro en x pos\n"
        nx=x+1
        ny=y
      end
      if (tempt_dir==SPIRAL_DIR_Y_POS) then
            print "Entro en y pos \n"
          nx=x
          ny=y+1
      end 
      if (tempt_dir==SPIRAL_DIR_X_NEG) then
            print "Entro en x neg\n"
            nx=x-1
            ny=y
      end
      if (tempt_dir==SPIRAL_DIR_Y_NEG) then
            print "Entro en y neg\n"
            nx=x
            ny=y-1
      end
      print "x es "+x.to_s+" nx es "+nx.to_s+"\n"
      print "y es "+y.to_s+" ny es "+ny.to_s+"\n"
    return nx,ny
  end

  def try_step(x,y,minx,miny,maxx,maxy,tempt)
     print "Probamos la dir tentativa "+tempt.to_s+" para la pos ["+x.to_s+","+y.to_s+"]\n"
     x,y=next_step_dir(x,y,tempt)
     if (x<=maxx && x>=minx) then
       if (y<=maxy && y>=miny) then
         ret=true
       else
         ret=false
       end
     end
     if (ret==true) then
      print "Miro si está libre la pos ["+x.to_s+","+y.to_s+"] y contiene="+(@table[x][y]).to_s+"\n"
       ret=not(@table[x][y])
     end
     return ret,x,y
  end

  def next_step(x,y,c,minx,miny,maxx,maxy,initdir)
    print "Busco el siguiente paso para ["+x.to_s+","+y.to_s+"] y c="+c.to_s+"\n"
    nc=c+1
    if (nc==1) then
      @direction = SPIRAL_DIR_X_POS
      @overflown = false
      init_table(x,y,c,minx,miny,maxx,maxy)
      nx=x+1
      ny=y
      @table[nx][ny]=true
      @table[x][y]=true
    else
      #Primero intentamos la dirección tentativa
      tempt_dir=next_spiral_dir(@direction)
      print "Direccion tentativa:"+tempt_dir.to_s+" actual:"+@direction.to_s+"\n"
      ret,nx,ny=try_step(x,y,minx,miny,maxx,maxy,tempt_dir)
      if (ret) then
        print "Funcionó la dirección tentativa"+tempt_dir.to_s+"\n"
        @direction = tempt_dir
        print "Marco como ocupada la posición ["+nx.to_s+","+ny.to_s+"]\n"
        @table[nx][ny]=true
      else
        # Si no ha sido posible, persistimos en la dirección actual
        ret,nx,ny=try_step(x,y,minx,miny,maxx,maxy,@direction)
        if (ret) then
          print "Funcionó la dirección anterior:"+@direction.to_s+"\n"
          print "Marco como ocupada la posición ["+nx.to_s+","+ny.to_s+"]\n"
          @table[nx][ny]=true
        else
          # Si no ha sido posible, entonces marcamos como barrido sobrepasado
          print "Ninguna de las direcciones ha funcionado, marco overflown\n"
          @overflown=true
        end
      end
    end
    x=nx
    y=ny
    c=nc
    print "La respuesta que doy es nx="+x.to_s+" y ny="+y.to_s+"\n"
    return x,y,c
  end

  def overflown?(x,y,c,minx,miny,maxx,maxy)
    if (c==0) then 
      ret=false
    else
      ret=@overflown
    end
    #print "Pregunto overflown con c="+c.to_s+" y retorno "+ret.to_s+"\n"
    return ret
  end  
  
end