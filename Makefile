libparser.a: parser.nim
	nim c --noMain:on -d:release --nimcache:nimcache --header=parser.h --app:staticLib parser.nim
