
JADE = ./node_modules/.bin/jade
PONY = ./node_modules/.bin/pony

HTML = index.html \
	api.html \
	api-ru.html \
	guide.html \
	guide-ru.html \
	applications.html \
	community.html \
	faq.html

JADE_EN := $(shell find en -type f -name '*.jade')
STM_RU  := $(patsubst en/%.jade,stm/ru/%.jade.stm,$(JADE_EN))
JADE_RU := $(patsubst en/%.jade,ru/%.jade,$(JADE_EN))

docs: $(HTML)

stm: $(STM_RU)

ru: $(JADE_RU)

stm/ru/%.jade.stm: en/%.jade
	@mkdir -p $(@D)
	$(PONY) stm $< $@

ru/%.jade: en/%.jade stm/ru/%.jade.stm
	@mkdir -p $(@D)
	$(PONY) translate $^ $@

%.html: %.jade
	$(JADE) --path $< < $< > $@

clean:
	rm -f *.html

.PHONY: docs clean stm ru