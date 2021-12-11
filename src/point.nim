type Point* = object
  x*: int
  y*: int

proc newPoint*(x, y: int): Point = Point(x: x, y: y)

