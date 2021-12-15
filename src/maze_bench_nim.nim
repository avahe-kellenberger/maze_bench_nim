import
  pixie,
  std/monotimes,
  strformat

import
  seq2d,
  point,
  mazesolver

proc main() =
  let image = readImage("maze1000.png")
  echo fmt"Loaded image: {image.width} x {image.height}"

  echo "Transforming image into maze..."

  var 
    now = getMonoTime()
    maze = newSeq2D(image.width, image.height)
  
  for i, rgba in image.data:
    maze[i] = (rgba.r + rgba.g + rgba.b) > 0
 
  echo fmt"Transformed image into maze in {getMonoTime() - now}"

  func toIdx(p:(int,int)):Point = (p[0] + p[1] * image.width,p[0],p[1])
  let
    start = (0, 1).toIdx
    finish = (2000, 1999).toIdx

  echo fmt"Solving maze from ({start.x}, {start.y}) to ({finish.x}, {finish.y}) ..."
  # Test "cold"
  now = getMonoTime()
  var success = maze.isReachable(start, finish)
  let coldTime = getMonoTime() - now

  # Warm up
  for _ in 0..1000:
    discard maze.isReachable(start, finish)

  # Test "warm"
  now = getMonoTime()
  success = maze.isReachable(start, finish)
  let warmTime = getMonoTime() - now

  if success:
    echo fmt"Solved maze in: cold={coldTime}, warm={warmTime}"
  else:
    echo "Failed to solve maze."

main()
