# Makefile for Fizzy 
# Install -> set exe bit and move to /usr/local/bin/
DESTDIR = /usr/local

all: 

install: 
	install src/fizzy $(DESTDIR)/bin
