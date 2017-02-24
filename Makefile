RESULT  = reso
SRC     = core
SOURCES = src/parser/BNFC_Util.ml   src/parser/AbsResolution.ml\
					src/parser/SkelResolution.ml src/parser/ShowResolution.ml src/parser/PrintResolution.ml\
					src/parser/ParResolution.mli src/parser/ParResolution.ml src/parser/LexResolution.ml\
					src/transform.mli src/naive.ml src/nameless.mli src/nameless.ml src/repl.ml src/resolution.ml

OCAMLFLAGS += -w @1-2..4-50 -w -3

all: native-code

bnfc:
	bnfc --ocaml  -o src/parser src/Resolution.bnfc

bnfc-clean:
	rm -rf src/parser

-include OCamlMakefile
