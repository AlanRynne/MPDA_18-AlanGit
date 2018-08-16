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
 $(addprefix $(SLIDES_PATH),$(SLIDES_NAME:.md=.html))

EXPORTED_DOCS=\
 $(EXPORTED_HTML5) \
 $(EXPORTED_PDF)\
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

#PANDOC document publishing options
# DOCUMENTCLASS can be {article, paper, book, memoir, report}
# CLASSOPTION=twocolumn for 2-column document.
# Number sections with -N
# Table of contents with --toc
# TOC depth with --toc-depth=X
# Cross-references requires to have pandoc-crossref installed and the use of -F pandoc-crossref BEFORE running the citations filter
# Citations & Bibliography with -F pandoc-citeproc (.bib file must be specified in the document's YAML frontmatter

# PANDOC 'PER DOCUMENT' FORMAT OPTIONS
PANDOC_OPTIONS=\
	--from markdown+implicit_figures+superscript+subscript+table_captions\
	-N\
	-F mermaid-filter\
	-F pandoc-crossref\
	-F pandoc-citeproc\
	--toc\
	--toc-depth=2
PANDOC_HTML_OPTIONS=\
	--to html5\
	--template=templates/template.html\
	--css=templates/template.css\
	--katex\
	--self-contained
PANDOC_PDF_OPTIONS=
PANDOC_DOCX_OPTIONS=\
	--reference-doc=templates/reference.docx
PANDOC_EPUB_OPTIONS=\
	--to epub
PANDOC_ICML_OPTIONS=\
	--filter=pandocsvg.py\
	--standalone\
	--katex
PANDOC_REVEALJS_OPTIONS=\
	--from markdown+smart\
	-t revealjs\
	-s\
	-V revealjs-url='http://lab.hakim.se/reveal-js'

#Export options per format
$(OUTPUT_PATH)%.html : $(INPUT_PATH)%.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_HTML_OPTIONS) -o $(OUTPUT_PATH)index.html $<
$(OUTPUT_PATH)%.pdf : $(INPUT_PATH)%.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_PDF_OPTIONS) -o $@ $(PDF_YAML) $<
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
$(SLIDES_PATH)%.html : $(SLIDES_PATH)%.md
	$(PANDOC) $(PANDOC_REVEALJS_OPTIONS) -o $@ $<


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
.PHONY: all clean clean-files clean-bundles final-docs bundle

all: final-docs

pdf: $(EXPORTED_PDF) $(SOURCE_DOCS)
html5: $(EXPORTED_HTML5) $(SOURCE_DOCS)
word: $(EXPORTED_WORD) $(SOURCE_DOCS)
ebook: $(EXPORTED_EPUB) $(SOURCE_DOCS)
indesign: $(EXPORTED_ICML) $(SOURCE_DOCS)

final-docs : pdf html5 word ebook indesign

slides: $(EXPORTED_SLIDES) $(SLIDES_DOCS)

bundle: pdf-bundle html5-bundle word-bundle epub-bundle indesign-bundle
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
	-$(RM) $(EXPORTED_SLIDES)
#USEFUL RULES
#Rule to print any variable. To use write 'make print-VARIABLE' in the terminal
print-%  : ; @echo $* = $($*)