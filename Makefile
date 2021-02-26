all:
	lit --param test_dir=. ./

clean:
	rm -Rf Output
	rm -Rf inter/Output
	rm -Rf tag/Output
	rm -f *.dot
