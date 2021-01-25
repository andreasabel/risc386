# Makefile for successful tests
# Author: Andreas Abel
# Created: 2013-07-16, copied from Agda/test/succeed

risc386=../../risc386

# Getting all assembly files (.s)

excluded=
alls=$(patsubst %.s,%.test,$(filter-out $(excluded),$(shell find . -name "*.s" | sort)))

all : $(alls)

%.test : %.s
	@echo ---------- $< ----------
	@$(risc386) $< 2> /dev/null

debug :
	@echo "alls = $(alls)"

clean :
	-rm *~

#EOF
