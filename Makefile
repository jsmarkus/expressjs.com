
JADE = ./node_modules/.bin/jade
PONY = ./node_modules/.bin/pony

HTML = index.html \
	api.html \
	guide.html \
	applications.html \
	community.html \
	faq.html\
	ru-index.html \
	ru-api.html \
	ru-guide.html \
	ru-applications.html \
	ru-community.html \
	ru-faq.html

JADE_EN := $(shell find en -type f -name '*.jade')
JADE_EN := $(JADE_EN) \
	$(shell find includes -type f -name '*.jade')
JADE_EN := $(JADE_EN) \
	index.jade \
	api.jade \
	guide.jade \
	applications.jade \
	community.jade \
	faq.jade

STM_RU  := $(patsubst %.jade,stm/ru/%.jade.stm,$(JADE_EN))
JADE_RU := $(patsubst %.jade,ru/%.jade,$(JADE_EN))


docs: $(HTML)

stm: $(STM_RU)

ru: $(JADE_RU)

stm/ru/%.jade.stm: %.jade
	@mkdir -p $(@D)
	$(PONY) stm $< $@

ru/%.jade: %.jade stm/ru/%.jade.stm
	@mkdir -p $(@D)
	$(PONY) translate $^ $@

%.html: %.jade
	$(JADE) --path $< < $< > $@

clean:
	rm -f *.html

.PHONY: docs clean stm ru