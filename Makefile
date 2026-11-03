# Each unit is a Typst book; the root is the repository so units can import lib/.
UNITS := estructuras-ordenadas logica-proposicional lenguajes-regulares

.PHONY: all $(UNITS)
all: $(UNITS)

$(UNITS):
	typst compile --root . $@/main.typ

watch-%:
	typst watch --root . $*/main.typ
