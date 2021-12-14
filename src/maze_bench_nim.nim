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
  var now = getMonoTime()

  let maze = newSeq2D[bool](image.width, image.height)

  var
    column: int
    row: int
  for i, rgba in image.data:
    maze[column, row] = (rgba.r + rgba.g + rgba.b) > 0
    if column + 1 >= image.width:
      column = 0
      row += 1
    else:
      column += 1

  echo fmt"Transformed image into maze in {getMonoTime() - now}"

  const 
    start: Point = (0, 1)
    finish: Point = (2000, 1999)

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
