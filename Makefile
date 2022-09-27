SRC=$(wildcard *.md)
PDF=$(subst .md,.pdf,$(SRC))
BAK=$(subst .md,.md.bak,$(SRC))
MARGIN=1.0in

all: $(PDF)

%.pdf: %.md $(CSS)
	pandoc -H header.tex -s $< -o $@

check:
	find . -type f -name '*.md' -exec aspell check {} \;

clean:
	rm -f $(PDF) $(BAK)
