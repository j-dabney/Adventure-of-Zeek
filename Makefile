# THIS NEEDS TO BE UPDATED -- NOT FINAL
LOCALES = en
PO_FILES = $(foreach loc,$(LOCALES),locale/$(loc).po)
MO_FILES = $(PO_FILES:.po=.mo)

all: $(MO_FILES)

%.mo: %.po
	msgfmt -o $@ $<

update_po:
	xgettext -o locale/messages.pot *.gd
	$(foreach po,$(PO_FILES),msgmerge --update $(po) locale/messages.pot;)

clean:
	rm -f locale/*.mo

.PHONY: all update_po clean
