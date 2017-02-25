all:
	ocaml setup.ml -build

bnfc:
	bnfc src/Resolution.bnfc -o src

clean:
	ocaml setup.ml -clean
