# Each unit is a Typst book and each exam a standalone document; the root is the
# repository so both can import lib/.
UNITS := estructuras-ordenadas logica-proposicional lenguajes-regulares
EXAMS := $(wildcard exams/*.typ)

.PHONY: all exams $(UNITS)
all: $(UNITS) exams

# exams/<name>.typ → exams/<name>.pdf
exams:
	@for f in $(EXAMS); do typst compile --root . $$f || exit 1; done

$(UNITS):
	typst compile --root . $@/main.typ

watch-%:
	typst watch --root . $*/main.typ
