
CODES= \
  HelloWorld \
  LabelBreak_1st \
  LabelBreak_2nd \
  LabelBreak_3rd

IDENTITY_TESTS=$(CODES:=-identityTranslator)

CFG_TESTS=$(CODES:=-virtualCFG)

TESTS=$(IDENTITY_TESTS) $(CFG_TESTS)

all: $(TESTS)

$(IDENTITY_TESTS): %-identityTranslator: %.java
	../scripts/test-rose-on-decompiled-java.sh $< identityTranslator

$(CFG_TESTS): %-virtualCFG: %.java
	../scripts/test-rose-on-decompiled-java.sh $< virtualCFG

clean:
	rm -rf $(TESTS)

