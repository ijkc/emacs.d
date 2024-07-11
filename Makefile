## -*- mode: makefile-gmake -*-

EMACS	    = emacs
EMACS_BATCH = $(EMACS) -batch
BATCH_LOAD  = $(EMACS_BATCH)

.PHONY: clean

all: init.elc

init.el: init.org
	@rm -f $@
	@$(BATCH_LOAD)						\
		--eval "(require 'org)"				\
		--eval "(org-babel-load-file \"init.org\")"
	@chmod 444 $@

init.elc: init.el

%.elc: %.el
	@echo Compiling file $<
	@$(BATCH_LOAD) -f batch-byte-compile $<

speed: init.elc
	time $(BATCH_LOAD) -Q -L . -l init		\
	    --eval "(message \"Hello, world\!\")"

slow: init.elc
	time $(BATCH_LOAD) -Q -L . -l init --debug-init	\
	    --eval "(message \"Hello, world\!\")"

clean:
	rm -f init.el *.elc *~
