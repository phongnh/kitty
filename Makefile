ifdef V
	VVAL=--verbose
endif
ifdef VERBOSE
	VVAL=--verbose
endif

all:
	python3 setup.py $(VVAL)

test:
	python3 setup.py $(VVAL) test

clean:
	python3 setup.py $(VVAL) clean

# A debug build
debug:
	python3 setup.py build $(VVAL) --debug

debug-event-loop:
	python3 setup.py build $(VVAL) --debug --extra-logging=event-loop

# Build with the ASAN and UBSAN sanitizers
asan:
	python3 setup.py build $(VVAL) --debug --sanitize

profile:
	python3 setup.py build $(VVAL) --profile

app:
	python3 setup.py kitty.app $(VVAL)
	cp kitty-zen.plist kitty.app/Contents/Info.plist
	rm -rf '/Applications/kitty zen.app'
	cp -fR kitty.app '/Applications/kitty zen.app'
	echo "Copied 'kitty.app' to '/Applications/kitty zen.app'"

man:
	$(MAKE) FAIL_WARN=$(FAIL_WARN) -C docs man

html:
	$(MAKE) FAIL_WARN=$(FAIL_WARN) -C docs html

linkcheck:
	$(MAKE) FAIL_WARN=$(FAIL_WARN) -C docs linkcheck

docs: man html
