import camdummy as cam

CAP_PROP_FRAME_WIDTH = 640
CAP_PROP_FRAME_HEIGHT = 480

def VideoCapture(x):
  return cam

def imwrite(path,frame):
  print("imwrite: path %s imagen %s" % (path,frame))

def imshow(title,frame):
  print("imshow: titulo %s imagen %s" % (title,frame))

def destroyAllWindows():
  print("Cierro todas las ventanas")
