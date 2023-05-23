## Building

`make`

## Current Output

`nimcache/parser.h` should contain the following

```
typedef struct tySequence__9bNRJkU9cJnNkESCDTQ7DgcQ tySequence__9bNRJkU9cJnNkESCDTQ7DgcQ;
typedef struct tySequence__9bNRJkU9cJnNkESCDTQ7DgcQ_Content tySequence__9bNRJkU9cJnNkESCDTQ7DgcQ_Content;

...


struct tySequence__9bNRJkU9cJnNkESCDTQ7DgcQ {
  NI len; tySequence__9bNRJkU9cJnNkESCDTQ7DgcQ_Content* p;
};
```

That means `seq[int]` in nim is opaque.

## Expected output

`nimcache/@mparser.nim.c` should contain the following

```
#ifndef tySequence__qwqHTkRvwhrRyENtudHQ7g_Content_PP
#define tySequence__qwqHTkRvwhrRyENtudHQ7g_Content_PP
struct tySequence__qwqHTkRvwhrRyENtudHQ7g_Content { NI cap; NI data[SEQ_DECL_SIZE];};
#endif
```

I expect `nimcache/parser.h` to contain this section as well.

