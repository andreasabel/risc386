# Makefile for failing tests
# Author: Andreas Abel
# Created: 2013-07-13, copied from Agda/test/fail

# How this file works
# ===================
#
# Whenever a .s file is modified,
# a corresponding .err file is generated to save the model error message
# for this file.  When the test suite is processed the next time, e.g.,
# after some hacking on the implementation, the new error message
# is compared to the saved one.  If they do not match, this is considered
# an error.  Then one has to verify the new error message is actually the
# intended one (manually), and remove the .err file.

risc386=../../risc386

# Enable read -n
SHELL=bash

# Getting all .s files
excluded=
alls=$(filter-out $(excluded),$(shell ls *.s))
allstems=$(patsubst %.s,%,$(alls))
allout=$(patsubst %.s,%.err,$(alls))

.PHONY : $(allstems)

all : $(allstems)

debug :
	@echo $(alls)

# No error recorded

$(allout) : %.err : %.s
	@echo "---------- $*.s ----------"
	@if $(risc386) $< 2> /dev/null > $*.tmp; \
		then echo "Unexpected success"; rm -f $*.tmp; false; \
    else if [ -s $*.tmp ]; \
				 then sed -E 's/[^ (]*test.fail.//g;s/[^ (]*test.Common.//g;s/:[[:digit:]]\+:$$//' $*.tmp > $@; cat $@; rm -f $*.tmp; true; \
				 else rm -f $@ $*.tmp; false; \
				 fi; \
		fi

# Existing error

$(allstems) : % : %.err
	@echo "---------- $*.s ----------"
	@if $(risc386) $*.s 2> /dev/null > $*.tmp.2; \
		then echo "Unexpected success"; rm -f $*.tmp.2; false; \
    else sed -e 's/[^ (]*test.fail.//g;s/[^ (]*test.Common.//g;s/\\/\//g;s/:[[:digit:]]\+:$$//' $*.tmp.2 > $*.tmp; \
				 echo `cat $*.err` | sed -e 's/\\/\//g' > $*.tmp.2; \
				 echo `cat $*.tmp` > $*.tmp.3; \
				 true; \
		fi
	@if cmp $*.tmp.2 $*.tmp.3; \
		then rm -f $*.tmp $*.tmp.2 $*.tmp.3; true; \
		else echo "== Old error ==="; \
			 cat $*.err; \
			 echo "== New error ==="; \
			 cat $*.tmp; \
			 /bin/echo -n "Accept new error [y/N/q]? "; \
			 read -n 1; \
			 echo ""; \
			 if [ "fckShPrg$$REPLY" != "fckShPrgy"  ]; \
			   then echo "Keeping old error"; [ "X$$REPLY" != "Xq" ]; \
			   else echo "Replacing error, continuing..."; \
			     mv $*.tmp $*.err; \
			     rm -f $*.tmp.2 $*.tmp.3; true; \
			 fi; \
	 fi


# Clean

clean :
	-rm -f *.tmp *~

# EOF
