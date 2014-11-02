# Makefile for Fizzy 
# Install -> set exe bit and move to /usr/local/bin/
DESTDIR = /usr/local

all: 

install: 
	install src/lasso $(DESTDIR)/bin
	install src/fizzy $(DESTDIR)/bin
	install src/npfs $(DESTDIR)/bin
