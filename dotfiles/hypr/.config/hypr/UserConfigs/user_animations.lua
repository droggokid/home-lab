hl.config({ animations = { enabled = true } })

hl.curve("wind", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("liner", { type = "bezier", points = { { 1, 1 }, { 1, 1 } } })

hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "liner" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 100, bezier = "liner", style = "loop" })
hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "wind", style = "slide" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3, bezier = "wind", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2, bezier = "wind", style = "slide" })
hl.animation({ leaf = "fade", enabled = true, speed = 2, bezier = "liner" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "wind" })
