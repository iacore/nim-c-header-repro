import npeg
import std/[strutils]

type PasswdLine {.exportc.} = object
  user: string
  pass: string
  uid: uint16
  gid: uint16
  desc: string
  home: string
  shell: string

type Slice[T] = object
  p*: ptr T
  len*: uint

func toSlice[T](a: openArray[T]): Slice[T] = Slice[PasswdLine](p: a[0].addr, len: a.len.uint)

const parser = peg("top", d: seq[PasswdLine]):
  top <- *(line * '\n') * ?line
  linebegin <- &1:
    d &= default(PasswdLine)
  validchar <- (1 - ':' - '\n')
  user <- >*validchar:
    d[^1].user = $1
  pass <- >*validchar:
    d[^1].pass = $1
  uid <- >*validchar:
    d[^1].uid = parseInt($1).uint16
  gid <- >*validchar:
    d[^1].gid = parseInt($1).uint16
  desc <- >*validchar:
    d[^1].desc = $1
  home <- >*validchar:
    d[^1].home = $1
  shell <- >*validchar:
    d[^1].shell = $1
  line <-
    linebegin *
    user * ":" *
    pass * ":" *
    uid * ":" *
    gid * ":" *
    desc * ":" *
    home * ":" *
    shell



proc parse_passwd(input: openArray[char]): Slice[PasswdLine] {.exportc, dynlib.} =
  var data {.global.}: seq[PasswdLine]
  doAssert parser.match(input, data).ok
  data.toSlice

when defined(main):
  var data: seq[PasswdLine]
  echo parser.matchFile("/etc/passwd", data)
  echo data
