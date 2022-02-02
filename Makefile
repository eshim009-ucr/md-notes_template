SRC=$(wildcard *.md)
PDF=$(subst .md,.pdf,$(SRC))
HTML=$(subst .md,.html,$(SRC))
BAK=$(subst .md,.md.bak,$(SRC))
CSS=style.css
MARGIN=0.5in

all: $(HTML) $(PDF)

html: $(HTML)

%.pdf: %.html
	wkhtmltopdf --enable-local-file-access \
		--margin-top $(MARGIN) \
		--margin-bottom $(MARGIN) \
		--margin-left $(MARGIN) \
		--margin-right $(MARGIN) \
		$< $@

%.html: %.md $(CSS)
	pandoc -s $< --pdf-engine=wkhtmltopdf --css=$(CSS) -o $@

check:
	find . -type f -name '*.md' -exec aspell check {} \;

clean:
	rm -f $(PDF) $(HTML) $(BAK)
