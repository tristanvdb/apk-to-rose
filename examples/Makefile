

TESTS=HelloWorld LabelBreak_1st LabelBreak_2nd LabelBreak_3rd

all: $(TESTS)

$(TESTS): %: %.java
	../scripts/test-rose-on-decompiled-java.sh $<

clean:
	rm -rf $(TESTS)

