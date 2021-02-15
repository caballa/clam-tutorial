all:
	lit --param test_dir=. ./
clean:
	rm -Rf Output
	rm -f *.dot
