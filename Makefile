IDIR = src/headers
SDIR = src
ODIR = obj
BDIR = bin

CC = gcc
CFLAGS = -Wall -I$(IDIR)
LIBS = -lm

_DEPS = lexer.h parser.h
DEPS = $(patsubst %,$(IDIR)/%,$(_DEPS))

_OBJ = main.o lexer.o parser.o
OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))

$(shell mkdir -p $(ODIR) $(BDIR))

all: $(BDIR)/assembler

$(ODIR)/%.o: $(SDIR)/%.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

$(BDIR)/assembler: $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

run: $(BDIR)/assembler
	$(BDIR)/assembler test_code.txt output.mem

clean:
	rm -f $(ODIR)/*.o *~ core $(IDIR)/*~ $(BDIR)/assembler

.PHONY: all clean run