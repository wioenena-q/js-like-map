# Package

version       = "1.0.0"
author        = "wioenena-q"
description   = "Object like JavaScript Map object for nim"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 1.6.6"


task tests, "Run all tests":
  exec "nim c -r --hints:off tests/main.nim"