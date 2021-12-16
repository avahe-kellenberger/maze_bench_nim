import
  seq2d,
  point

proc isReachable*(maze: Seq2D; start, finish: Point): bool =
  var 
    unvisited = maze
    stack = @[start]
  
  while stack.len != 0:
    let p = stack.pop()
    unvisited[p.i] = false
    if p.i == finish.i: return true
    for (di,dx,dy) in [(-maze.width,0,-1),(maze.width,0,1),(-1,-1,0),(1,1,0)]:
      let np:Point = (p.i+di,p.x+dx,p.y+dy)
      if likely(np.x>=0) and likely(np.y >= 0) and likely(np.x < maze.width) and likely(np.y < maze.height):
          if unvisited[np.i]:
            stack.add(np)
  return false