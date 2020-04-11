# Source/target file name
TARGET=main
# Build directory
BUILDDIR=out

.PHONY: $(TARGET).pdf # Let latexmk handle the dependencies / rebuild detection
$(TARGET).pdf: $(TARGET).tex
	if [ ! -d $(BUILDDIR) ]; then mkdir $(BUILDDIR); fi
	latexmk -output-directory=$(BUILDDIR) -pdf -pdflatex="pdflatex" $<
	cp $(BUILDDIR)/$@ $@

# preview document and continuously update:
.PHONY: preview-continuously
preview-continuously: $(TARGET).pdf
	zathura $(BUILDDIR)/$(TARGET).pdf 2>/dev/null & \
	  export ZATHURA_PID=$$! && \
	  latexmk -output-directory=$(BUILDDIR) -pvc -view=none -pdf \
	    -pdflatex="pdflatex -interaction=nonstopmode" $(TARGET).tex && \
	  kill $$ZATHURA_PID

.PHONY: clean
clean:
	if [ -d $(BUILDDIR) ]; then rm --recursive ./$(BUILDDIR); fi

.PHONY: distclean
distclean: clean
	if [ -f $(TARGET).pdf ]; then rm $(TARGET).pdf; fi

.PHONY: info
info:
	@echo 'Main source file: $(TARGET).tex'
	@echo 'Build directory: $(BUILDDIR)'

.PHONY: help
help:
	@echo 'Build targets:'
	@echo '  $(TARGET).pdf   - Build the current exercise'
	@echo 'Auxiliary targets:'
	@echo '  info           - Show the current configuration of the Makefile'
	@echo '  help           - Show this help'
	@echo 'Cleaning targets:'
	@echo '  clean          - Remove the build directory ("$(BUILDDIR)")'
	@echo '  distclean      - Remove the build directory ("$(BUILDDIR)")' \
	  'and $(TARGET).pdf (i.e. everything)'
