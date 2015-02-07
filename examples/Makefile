
CODES= \
  HelloWorld \
  LabelBreak_1st \
  LabelBreak_2nd \
  LabelBreak_3rd

IDENTITY_TESTS=$(CODES:=-identityTranslator)

CFG_TESTS=$(CODES:=-virtualCFG)

CFG_VIZ=$(CODES:=.svg)

CFG_JD_VIZ=$(CODES:=.jd.svg)

all: identity-tests cfg-tests cfg-viz cfg-jd-viz

identity-tests: $(IDENTITY_TESTS)

cfg-tests: $(CFG_TESTS)

cfg-viz: $(CFG_VIZ)

cfg-jd-viz: $(CFG_JD_VIZ)

$(IDENTITY_TESTS): %-identityTranslator: %.java
	../scripts/test-rose-on-decompiled-java.sh $< identityTranslator

$(CFG_TESTS): %-virtualCFG: %.java
	../scripts/test-rose-on-decompiled-java.sh $< virtualCFG

$(CFG_VIZ): %.svg: %-virtualCFG
	dot -Tsvg $</$(@:.svg=.java).main.interesting.dot -o $@

$(CFG_JD_VIZ): %.jd.svg: %-virtualCFG
	dot -Tsvg $</jd/$(@:.jd.svg=.java).main.interesting.dot -o $@

clean:
	rm -rf $(IDENTITY_TESTS) $(CFG_TESTS) $(CFG_VIZ) $(CFG_JD_VIZ)

