from std/tables import TableRef, `[]=`, `[]`, contains, hasKey, len, del, pairs,
    keys, values
from std/options import Option, some, none

type
  JSLikeMap[K, V] = ref object
    cache: TableRef[K, V]



proc newJSLikeMap*[K, V](): JSLikeMap[K, V] =
  ## Create a new empty map
  var map = JSLikeMap[K, V].new
  map.cache = TableRef[K, V]()

  map


proc set*[K, V](m: JSLikeMap[K, V], key: K, value: V): JSLikeMap[K,
    V] {.discardable.} =
  ## Add a key-value pair to the map.
  ## Return the this map.
  m.cache[key] = value

  m

proc get*[K, V](m: JSLikeMap[K, V], key: K): Option[V] =
  ## Get the value for a key from the map.
  if key in m.cache:
    some m.cache[key]
  else:
    none int

proc has*[K, V](m: JSLikeMap[K, V], key: K): bool =
  ## Return true if the map has a value for the given key.
  m.cache.hasKey key

proc delete*[K, V](m: JSLikeMap[K, V], key: K): bool =
  ## Remove a key from the map.
  ## Return true if an element in the Map object existed and has been removed, or false if the element does not exist.

  if not m.has key:
    return false
  m.cache.del key
  true

proc clear*[K, V](m: JSLikeMap[K, V]): void =
  ## Remove all keys from the map.
  m.cache.clear

proc size*[K, V](m: JSLikeMap[K, V]): int =
  ## Return the number of keys in the map.
  m.cache.len


iterator entries*[K, V](m: JSLikeMap[K, V]): tuple[key: K, val: V] =
  ## Return an iterator over the map's entries.
  for k, v in m.cache.pairs:
    yield (key: k, val: v)

proc forEach*[K, V](m: JSLikeMap[K, V], p: proc (
    value: V, key: K, map: JSLikeMap[K, V]): void {.closure.}): void =
  ## Call a function for each entry in the map.
  for k, v in m.cache.pairs:
    p(v, k, m)


iterator keys*[K, V](m: JSLikeMap[K, V]): lent K =
  ## Return an iterator over the map's keys.
  for k in m.cache.keys:
    yield k

iterator values*[K, V](m: JSLikeMap[K, V]): lent V =
  ## Return an iterator over the map's values.
  for v in m.cache.values:
    yield v


