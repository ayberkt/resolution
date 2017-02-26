all:
	ocaml setup.ml -build

oasis:
	oasis setup && ocaml setup.ml -configure

bnfc:
	bnfc src/Resolution.bnfc --ocaml  -o src

bnfc-clean:
	rm src/AbsResolution.ml
	rm src/LexResolution.mll
	rm src/ParResolution.mly
	rm src/SkelResolution.ml
	rm src/PrintResolution.ml
	rm src/ShowResolution.ml
	rm src/TestResolution.ml
	rm src/BNFC_Util.ml

clean:
	ocaml setup.ml -clean
