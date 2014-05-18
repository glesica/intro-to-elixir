all: slides notes

slides: slides.pdf slides.html
notes: notes.pdf

clean:
	rm -f *.pdf *.html

slides.pdf: slides.md
	pandoc -S -t beamer -o $@ $<

slides.html: slides.md
	pandoc -S -t slidy --self-contained -o $@ $<

%.pdf: %.md
	pandoc -S -o $@ $<
