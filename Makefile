### DEFINITIONS ###
# The prefix is used to separate node documents from templates and subdocuments
PREFIX=notes_
SRC=$(wildcard $(PREFIX)*.md)
# Output PDF files #
PDF=$(subst .md,.pdf,$(SRC))
# Spellcheck backup files #
BAK=$(subst .md,.md.bak,$(SRC))

### TARGETS ###
all: $(PDF)

# Build PDF #
%.pdf: %.md $(CSS)
	pandoc -H header.tex -s $< -o $@

# Spellcheck source files #
check:
	find . -type f -name '*.md' -exec \
		aspell --extra-dicts ./local-dict.pws check -t {} \
	\;

# Generate a new notes document from the template #
new:
	NEW_FILENAME="$(PREFIX)$$(date -I).md" && \
	cp -n template.md $$NEW_FILENAME && \
	sed -i -e "s/DATE/$$(date '+%B %-d, %Y')/g" $$NEW_FILENAME && \
	sed -i -e "s/DAY/$$(date '+%A')/g" $$NEW_FILENAME

# Remove all output files #
clean:
	rm -f $(PDF) $(BAK)
