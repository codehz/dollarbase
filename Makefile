COSMO?=$(HOME)/.cosmo
CC=$(COSMO)/bin/cosmocc
AR=$(COSMO)/bin/cosmoar
CFLAGS=-O2

SRC := $(wildcard *.m)
OBJ := $(SRC:.m=.o)

libdollar.a: $(OBJ)
	$(AR) rcs $@ $^

%.o: %.m
	$(CC) -c $< -o $@ $(CFLAGS)