CC=gcc
CFLAGS=-Wall -pedantic -g -DUNIX_HOST
LIBS=-lm -lreadline

TARGET	= picoc
SRCS	= src/picoc.c src/table.c src/lex.c src/parse.c \
	src/expression.c src/heap.c src/type.c \
	src/variable.c src/clibrary.c src/platform.c src/include.c \
	platform/platform_unix.c platform/library_unix.c \
	cstdlib/stdio.c cstdlib/math.c cstdlib/string.c cstdlib/stdlib.c \
	cstdlib/time.c cstdlib/errno.c cstdlib/ctype.c cstdlib/stdbool.c \
	cstdlib/unistd.c
OBJS	:= $(SRCS:%.c=%.o)

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJS) $(LIBS)

test:	all
	(cd tests; make test)

clean:
	rm -f $(TARGET) $(OBJS) *~

count:
	@echo "Core:"
	@cat src/picoc.h interpreter.h picoc.c table.c lex.c parse.c expression.c platform.c heap.c type.c variable.c include.c | grep -v '^[ 	]*/\*' | grep -v '^[ 	]*$$' | wc
	@echo ""
	@echo "Everything:"
	@cat $(SRCS) *.h */*.h | wc

.PHONY: clibrary.c

src/picoc.o: src/picoc.c src/picoc.h
src/table.o: src/table.c src/interpreter.h src/platform.h
src/lex.o: src/lex.c src/interpreter.h src/platform.h
src/parse.o: src/parse.c src/picoc.h src/interpreter.h src/platform.h
src/expression.o: src/expression.c src/interpreter.h src/platform.h
src/heap.o: src/heap.c src/interpreter.h src/platform.h
src/type.o: src/type.c src/interpreter.h src/platform.h
src/variable.o: src/variable.c src/interpreter.h src/platform.h
src/clibrary.o: src/clibrary.c src/picoc.h src/interpreter.h src/platform.h
src/platform.o: src/platform.c src/picoc.h src/interpreter.h src/platform.h
src/include.o: src/include.c src/picoc.h src/interpreter.h src/platform.h
platform/platform_unix.o: platform/platform_unix.c src/picoc.h src/interpreter.h src/platform.h
platform/library_unix.o: platform/library_unix.c src/interpreter.h src/platform.h
cstdlib/stdio.o: cstdlib/stdio.c src/interpreter.h src/platform.h
cstdlib/math.o: cstdlib/math.c src/interpreter.h src/platform.h
cstdlib/string.o: cstdlib/string.c src/interpreter.h src/platform.h
cstdlib/stdlib.o: cstdlib/stdlib.c src/interpreter.h src/platform.h
cstdlib/time.o: cstdlib/time.c src/interpreter.h src/platform.h
cstdlib/errno.o: cstdlib/errno.c src/interpreter.h src/platform.h
cstdlib/ctype.o: cstdlib/ctype.c src/interpreter.h src/platform.h
cstdlib/stdbool.o: cstdlib/stdbool.c src/interpreter.h src/platform.h
cstdlib/unistd.o: cstdlib/unistd.c src/interpreter.h src/platform.h
