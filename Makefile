simdest=$(HOME)/public_html

GHC = ghc
GHC_OPTS = -ignore-package monads-fd
# -fglasgow-exts 

ghc=$(GHC) $(GHC_OPTS)

simout   = risc386
simstems = Util GenSym Frame Intel Wellformed FrameIntel TokenIntel LexIntel ParseIntel StateIntel MainIntel
simsrcs  = $(foreach stem,$(simstems),$(stem).hs)
simpack  = risc386.cabal Makefile LIESMICH.html README.txt LICENSE LexIntel.x ParseIntel.y $(simsrcs) $(simout) test

.PHONY : dist default sim simship test clean veryclean

default : risc386

sim : $(simout)

$(simout) : $(simsrcs)
	$(ghc) --make -o $@ MainIntel.hs

dist : $(simpack)
	cabal sdist
	cp -p dist/risc386*.tar.gz $(simdest)

simship : sim.tar.gz
	cp -p $^ $(simdest)

sim.tar.gz : $(simpack)
	tar czf $@ $^

%.hs:	%.y
	happy -iGRM.LOG $<

%.hs:	%.x
	alex $<

%.o:	%.hs
	$(GHC) $(GHC_OPTS) -c -o $@ $<

# Tests

test : succeed fail

succeed : 
	make -C test/succeed

fail : 
	make -C test/fail

# Clean

testclean :
	-make -C test/succeed clean
	-make -C test/fail clean

clean:
	-rm *.hi *.o risc386

veryclean: testclean
	-rm *.hi *.o MJLex.hs MJParse.hs risc386
