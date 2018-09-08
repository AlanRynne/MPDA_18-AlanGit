# Master Thesis Read Me!

This repository contains all of my master thesis work on geodesic patterns.

ALL input files should go into `input/` folder.

* `Your_Title.md`: This is the Markdown file to be converted into a paper/book.
* `Your_Title.bib`: Your file in .bibtex format containing all the bibliography for the paper.
* FOLDER->`resources/pythonplots/`: This folder should contain all of the python scritps that should be processed before the paper
* FOLDER->`resources/rawData/`: Should contain all the data files needed for the plots in CSV format.

Output behaviour is controled by the Makefile.

To output in article format:

> Enter `make final-docs` to convert the .md file into HTML5,PDF,DOCX,EPUB and ICML.  
> or  
> Enter `make pdf` to generate just the pdf version.
`
Other commands for publishing a single file format are available (check the lower part of the makefile)

All output files will be saved in the `output/` folder.


Run this command for slides (I will make a Makefile command shortly)

```command
pandoc -s -f markdown+implicit_figures+superscript+subscript+table_captions+fenced_code_blocks -F mermaid-filter -F pandoc-crossref -F pandoc-citeproc -t revealjs slides/slides.md -o slides/index.html -V revealjs-url=../slides/reveal.js-master -V theme=white --slide-level 2 --katex
```

Beamer
```command
pandoc -s -f markdown+implicit_figures+superscript+subscript+table_captions -F mermaid-filter -F pandoc-crossref -F pandoc-citeproc -t beamer slides/slides.md -o slides/index.pdf --slide-level 2 --katex
```

Slidy
```command
pandoc -s -f markdown+implicit_figures+superscript+subscript+table_captions -F mermaid-filter -F pandoc-crossref -F pandoc-citeproc -t dzslides slides/slides.md -o slides/index.html --slide-level 2 --katex
```
