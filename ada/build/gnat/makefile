TOP			=	../..
SRC			=	$(TOP)/src
DOC_SRC		=	$(TOP)/doc

GEN			=	gen
DOC_GEN		=	$(GEN)/doc

DESTDIR		?=	/opt

GPRBUILD	=	gprbuild
GPRINSTALL	=	gprinstall
GPRCLEAN	=	gprclean
INSTALL		=	install
CAT			=	cat

IQ_MODE	?=	debug

#########################################################################################################################

all: iq.gpr

.PHONY: iq.gpr

# Add lib targets here.
iq.gpr:
	$(GPRBUILD) -p -XIQ_MODE=$(IQ_MODE) -Piq.gpr

# Add clean lib targets here

.PHONY: clean

clean:
	$(GPRCLEAN) -Piq.gpr

#########################################################################################################################

.PHONY: todo

todo:
	grep -riw --color TODO $(SRC)
