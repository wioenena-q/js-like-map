# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest, options

import js_like_map

var map = newJSLikeMap[string, int]()

suite "JSLikeMap":
  test "set item to map":
    assert map.set("a", 1) == map

  test "get item from map":
    assert map.get("a").isSome
    assert map.get("b").isNone
    assert map.get("a").get == 1


  test "has item in map":
    assert map.has("a")
    assert not map.has("b")

  test "delete item from map":
    assert map.size == 1
    assert map.delete("a") == true
    assert not map.has("a")
    assert map.size == 0

  test "entries":
    for x in 0..10:
      map.set($x, x)

    for k, v in map.entries:
      assert k is string
      assert v is int

  test "forEach":
    map.forEach do (v: int, k: string, m: typeof(map)) -> void:
      assert v is int
      assert k is string
      assert m is typeof(map)

  test "keys":
    for k in map.keys:
      assert k is string

  test "values":
    for v in map.values:
      assert v is int
