# Makefile
# 
# Converts Markdown to other formats (HTML, PDF, DOCX, RTF, ODT, EPUB) using Pandoc
# <http://johnmacfarlane.net/pandoc/>
#
# Run "make" (or "make pdf") to convert to PDF format
# Run "make" (or "make all") to convertm to all other formats

#
# Run "make clean" to delete converted files

# Convert all files in this directory that have a .md suffix
OUTPUT_PATH= output
INPUT_PATH= input

SOURCE_DOCS = $(wildcard $(INPUT_PATH)/*.md)
FILE_NAME = $(notdir $(SOURCE_DOCS))

# Remove command
RM=/bin/rm
PANDOC=/usr/local/bin/pandoc

#FORMATS TO EXPORT
#Added individual variables for each format to be able to make only one desired format at a time, or all at once using just 'make'.

EXPORTED_PDF=\
 $(OUTPUT_PATH)/$(FILE_NAME:.md=.pdf)

EXPORTED_HTML5=\
 $(OUTPUT_PATH)/$(FILE_NAME:.md=.html)

EXPORTED_EPUB=\
 $(OUTPUT_PATH)/$(FILE_NAME:.md=.epub)

EXPORTED_WORD=\
 $(OUTPUT_PATH)/$(FILE_NAME:.md=.docx)

EXPORTED_ICML=\
 $(OUTPUT_PATH)/$(FILE_NAME:.md=.icml)

EXPORTED_DOCS=\
 $(EXPORTED_HTML5) \
 $(EXPORTED_PDF)\
 $(EXPORTED_WORD) \
 $(EXPORTED_EPUB) \
 $(EXPORTED_ICML)


#PANDOC document publishing options
# DOCUMENTCLASS can be {article, paper, book, memoir, report}
# CLASSOPTION=twocolumn for 2-column document.
# Number sections with -N
# Table of contents with --toc
# TOC depth with --toc-depth=X
# Cross-references requires to have pandoc-crossref installed and the use of -F pandoc-crossref BEFORE running the citations filter
# Citations & Bibliography with -F pandoc-citeproc (.bib file must be specified in the document's YAML frontmatter

# OTHER 'PER DOCUMENT FORMAT' OPTIONS

PANDOC_OPTIONS=\
	--from markdown+implicit_figures+superscript+subscript+table_captions\
	--variable documentclass=article\
	-N\
	--toc\
	--toc-depth=2\
	-F pandoc-crossref\
	-F pandoc-citeproc

PANDOC_HTML_OPTIONS=\
	--to html5\
	--template=templates/template.html\
	--css=templates/template.css\
	--katex\
	--self-contained

PANDOC_PDF_OPTIONS=
PANDOC_DOCX_OPTIONS=
PANDOC_EPUB_OPTIONS=\
	--to epub
PANDOC_ICML_OPTIONS=

#Export options per format
$(OUTPUT_PATH)/%.html : $(INPUT_PATH)/%.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_HTML_OPTIONS) -o $@ $<
$(OUTPUT_PATH)/%.pdf : $(INPUT_PATH)/%.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_PDF_OPTIONS) -o $@ $<
$(OUTPUT_PATH)/%.docx : $(INPUT_PATH)/%.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_DOCX_OPTIONS) -o $@ $<
$(OUTPUT_PATH)/%.rtf : $(INPUT_PATH)/%.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_RTF_OPTIONS) -o $@ $<
$(OUTPUT_PATH)/%.odt : $(INPUT_PATH)/%.md 
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_ODT_OPTIONS) -o $@ $<
$(OUTPUT_PATH)/%.epub : $(INPUT_PATH)/%.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_EPUB_OPTIONS) -o $@ $<
$(OUTPUT_PATH)/%.icml :$(INPUT_PATH)/%.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_ICML_OPTIONS) -o $@ $<

# Targets and dependencies

.PHONY: all clean

final-docs : pdf html5 word ebook indesign

pdf: $(EXPORTED_PDF) $(SOURCE_DOCS)

html5: $(EXPORTED_HTML5) $(SOURCE_DOCS)

word: $(EXPORTED_WORD) $(SOURCE_DOCS)

ebook: $(EXPORTED_EPUB) $(SOURCE_DOCS)

indesign: $(EXPORTED_ICML) $(SOURCE_DOCS)

#Clean output files
clean:
	- $(RM) $(EXPORTED_DOCS)

#USEFUL RULES
#Rule to print any variable. To use write 'make print-VARIABLE' in the terminal
print-%  : ; @echo $* = $($*)


