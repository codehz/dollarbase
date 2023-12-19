COSMO?=$(HOME)/.cosmo
CC=$(COSMO)/bin/cosmocc
AR=$(COSMO)/bin/cosmoar
CFLAGS=-Os -std=gnu11 -fconstant-string-class=\$$String -fobjc-exceptions

SRC := $(wildcard *.m)
OBJ := $(SRC:.m=.o)

libdollar.a: $(filter-out test.o, $(OBJ))
	$(AR) rcs $@ $^

test: $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS) -lobjc

%.o: %.m
	$(CC) -c $< -o $@ $(CFLAGS)