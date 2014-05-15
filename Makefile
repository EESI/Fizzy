# Makefile for Fizzy 
# Install -> set exe bit and move to /usr/local/bin/
DESTDIR = /usr/local

install: 
	install src/fizzy $(DESTDIR)/bin
