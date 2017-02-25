all:
	ocaml setup.ml -build

bnfc:
	bnfc src/Resolution.bnfc --ocaml  -o src

clean:
	ocaml setup.ml -clean
