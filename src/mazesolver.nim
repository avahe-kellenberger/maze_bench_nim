import
  seq2d,
  point

proc isReachable*(maze: Seq2D[bool], start, finish: Point): bool =
  let
    width = maze.width
    widthM1 = width - 1
    height = maze.height
    heightM1 = height - 1
    visited = newSeq2D[bool](width, height)

  var
    stack = newSeq[Point]()
    p: Point = start

  visited[start.x, start.y] = true

  while true:
    # Check if we've reached the end
    if p == finish:
      return true

    # Check left
    if p.x > 0:
      let left = p.x - 1
      if not visited[left, p.y] and maze[left, p.y]:
        # Go left
        stack.add((left, p.y))
        visited[left, p.y] = true

    # Check right
    if p.x < widthM1:
      let right = p.x + 1
      if not visited[right, p.y] and maze[right, p.y]:
        # Go right
        stack.add((right, p.y))
        visited[right, p.y] = true

    # Check up
    if p.y > 0:
      let up = p.y - 1
      if not visited[p.x, up] and maze[p.x, up]:
        # Go up
        stack.add((p.x, up))
        visited[p.x, up] = true

    # Check down
    if p.y < heightM1:
      let down = p.y + 1
      if not visited[p.x, down] and maze[p.x, down]:
        # Go down
        stack.add((p.x, down))
        visited[p.x, down] = true

    if stack.len == 0:
      break
    
    p = stack.pop()

  return false

