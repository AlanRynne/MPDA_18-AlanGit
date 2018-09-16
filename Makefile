# Makefile
# 
# Converts Markdown to other formats (HTML, PDF, DOCX, RTF, ODT, EPUB) using Pandoc
# <http://johnmacfarlane.net/pandoc/>
#
# Run "make" (or "make pdf") to convert to PDF format
#
# Run "make clean" to delete converted files


# Convert all files in this directory that have a .md suffix
BUNDLE_NAME = BundlePaper
OUTPUT_PATH= output/
INPUT_PATH= input/
SLIDES_PATH= slides/
PDF_YAML = input/paper.yaml
SOURCE_DOCS = $(wildcard $(INPUT_PATH)*.md)
SLIDES_DOCS = $(wildcard $(SLIDES_PATH)*.md)
IMAGES = $(wildcard resources/images/svg/*.svg)
FILE_NAME = $(notdir $(SOURCE_DOCS))
SLIDES_NAME = $(notdir $(SLIDES_DOCS))

# Remove command
RM=/bin/rm -rf
PANDOC=/usr/local/bin/pandoc

#FORMATS TO EXPORT
#Added individual variables for each format to be able to make only one desired format at a time, or all at once using just 'make'.

EXPORTED_PDF=\
 $(addprefix $(OUTPUT_PATH),$(FILE_NAME:.md=.pdf))

EXPORTED_HTML5=\
 $(addprefix $(OUTPUT_PATH),$(FILE_NAME:.md=.html))

EXPORTED_EPUB=\
 $(addprefix $(OUTPUT_PATH),$(FILE_NAME:.md=.epub))

EXPORTED_WORD=\
 $(addprefix $(OUTPUT_PATH),$(FILE_NAME:.md=.docx))

EXPORTED_ICML=\
 $(addprefix $(OUTPUT_PATH),$(FILE_NAME:.md=.icml))

EXPORTED_SLIDES=\
 $(addprefix $(OUTPUT_PATH),$(SLIDES_NAME:.md=.html))

EXPORTED_BEAMER_SLIDES=\
 $(addprefix $(OUTPUT_PATH),$(SLIDES_NAME:.md=.pdf))

EXPORTED_DOCS=\
 $(EXPORTED_HTML5) \
 $(EXPORTED_PDF) \
 $(EXPORTED_WORD) \
 $(EXPORTED_EPUB) \
 $(EXPORTED_ICML)

#Exported bundle file names
EXPORTED_BUNDLES=\
$(OUTPUT_PATH)$(BUNDLE_NAME).pdf\
$(OUTPUT_PATH)$(BUNDLE_NAME).html\
$(OUTPUT_PATH)$(BUNDLE_NAME).docx\
$(OUTPUT_PATH)$(BUNDLE_NAME).epub\
$(OUTPUT_PATH)$(BUNDLE_NAME).icml

# PANDOC 'PER DOCUMENT' FORMAT OPTIONS
PANDOC_OPTIONS=\
	--from markdown+implicit_figures+superscript+subscript+table_captions+fenced_divs\
	-N\
	-F mermaid-filter\
	-F pandoc-crossref\
	-F pandoc-citeproc
PANDOC_HTML_OPTIONS=\
	--to html5\
	--css=templates/pandoc.css\
	--katex\
	-s\
	--self-contained\
	--toc\
	--toc-depth=3\
	-M date="Last updated: `date +"%x"`"
PANDOC_PDF_OPTIONS=\
	$(PDF_YAML)\
	--include-after=input/appendix.tex
PANDOC_DOCX_OPTIONS=\
	--reference-doc=templates/reference.docx
PANDOC_EPUB_OPTIONS=\
	--to epub
PANDOC_ICML_OPTIONS=\
	--standalone\
	--katex
PANDOC_REVEALJS_OPTIONS=\
	-f markdown+smart+implicit_figures+superscript+subscript+table_captions+fenced_divs\
	-t revealjs\
	-V revealjs-url=../slides/reveal.js/\
	-V theme=serif\
	--slide-level 2\
	-s\
	-N\
	-F mermaid-filter\
	-F pandoc-crossref\
	-F pandoc-citeproc\
	--katex
PANDOC_BEAMER_OPTIONS=\
	--filter=pandoc-svg.py\
	-f markdown+smart+implicit_figures+superscript+subscript+table_captions+fenced_divs\
	-t beamer\
	-s\
	-N\
	--slide-level=2\
	--katex\
 	-F mermaid-filter\
	-F pandoc-crossref\
	-F pandoc-citeproc\
	--dpi=300


#Export options per format
$(OUTPUT_PATH)%.html : $(INPUT_PATH)%.md templates/pandoc.css
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_HTML_OPTIONS) -o $@ $<

$(OUTPUT_PATH)%.pdf : $(INPUT_PATH)%.md $(PDF_YAML)
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_PDF_OPTIONS) -o $@ $<

$(OUTPUT_PATH)%.docx : $(INPUT_PATH)%.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_DOCX_OPTIONS) -o $@ $<

$(OUTPUT_PATH)%.rtf : $(INPUT_PATH)%.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_RTF_OPTIONS) -o $@ $<

$(OUTPUT_PATH)%.odt : $(INPUT_PATH)%.md 
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_ODT_OPTIONS) -o $@ $<

$(OUTPUT_PATH)%.epub : $(INPUT_PATH)%.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_EPUB_OPTIONS) -o $@ $<

$(OUTPUT_PATH)%.icml :$(INPUT_PATH)%.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_ICML_OPTIONS) -o $@ $<

$(OUTPUT_PATH)%.html : $(SLIDES_PATH)%.md $(SLIDES_PATH)slides.css
	$(PANDOC) $(PANDOC_REVEALJS_OPTIONS) -o $@ $<

$(OUTPUT_PATH)%.pdf : $(SLIDES_PATH)%.md
	$(PANDOC) $(PANDOC_BEAMER_OPTIONS) -o $@ $<


#Export options for exporting all files as one single file
$(OUTPUT_PATH)$(BUNDLE_NAME).pdf : $(SOURCE_DOCS)
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_PDF_OPTIONS) -o $@ $^

$(OUTPUT_PATH)$(BUNDLE_NAME).docx : $(SOURCE_DOCS)
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_DOCX_OPTIONS) -o $@ $^

$(OUTPUT_PATH)$(BUNDLE_NAME).html : $(SOURCE_DOCS)
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_HTML_OPTIONS) -o $@ $^
	
$(OUTPUT_PATH)$(BUNDLE_NAME).epub : $(SOURCE_DOCS)
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_DOCX_OPTIONS) -o $@ $^

$(OUTPUT_PATH)$(BUNDLE_NAME).icml : $(SOURCE_DOCS)
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_DOCX_OPTIONS) -o $@ $^




# Targets and dependencies
.PHONY: final-docs clean clean-files clean-bundles clean-slides 

.DEFAULT_GOAL:= final-docs

final-docs :\
 pdf\
 html5\
 slides

pdf: $(EXPORTED_PDF) $(SOURCE_DOCS)
html5: $(EXPORTED_HTML5) $(SOURCE_DOCS)
word: $(EXPORTED_WORD) $(SOURCE_DOCS)
ebook: $(EXPORTED_EPUB) $(SOURCE_DOCS)
indesign: $(EXPORTED_ICML) $(SOURCE_DOCS)
slides: reveal-slides beamer-slides
reveal-slides: $(EXPORTED_SLIDES) $(SLIDES_DOCS)
beamer-slides: $(EXPORTED_BEAMER_SLIDES) $(SLIDES_DOCS)

bundle: pdf-bundle html5-bundle
pdf-bundle: $(OUTPUT_PATH)$(BUNDLE_NAME).pdf $(SOURCE_DOCS)
html5-bundle: $(OUTPUT_PATH)$(BUNDLE_NAME).html $(SOURCE_DOCS)
word-bundle: $(OUTPUT_PATH)$(BUNDLE_NAME).docx $(SOURCE_DOCS)
epub-bundle: $(OUTPUT_PATH)$(BUNDLE_NAME).epub $(SOURCE_DOCS)
indesign-bundle: $(OUTPUT_PATH)$(BUNDLE_NAME).icml $(SOURCE_DOCS)

#Clean output files
clean: clean-files clean-bundles clean-slides
clean-files:
	-$(RM) $(EXPORTED_DOCS)
clean-bundles:
	-$(RM) $(EXPORTED_BUNDLES)
clean-slides:
	-$(RM) $(EXPORTED_SLIDES) $(EXPORTED_BEAMER_SLIDES)

#USEFUL RULES
#Rule to print any variable. To use write 'make print-VARIABLE' in the terminal
print-%  : ; @echo $* = $($*)