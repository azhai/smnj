M68FLAGS = -f68881
VAXFLAGS =
# $(VAXFLAGS) or $(M68FLAGS)
#FLAGS = $(VAXFLAGS)
FLAGS = $(M68FLAGS)

# VAX or M68
#MACHINE = VAX
MACHINE = M68

# BSD or V9
OPSYS = BSD
#OPSYS = V9

# Other possible #define's:
# PROFILE:  for an nml which counts allocs.
# CHECKUP:  looks at to_space after a garbage collection. (busted)
# NOTDEF:   ???
# NEWTAGS:  use the new descriptors (strings not changed)
DEFINES = -D$(OPSYS) -D$(MACHINE) -DNEWTAGS

CFLAGS = -g $(DEFINES) $(FLAGS)

nml: run.o gc.o callgc.o prim.o prof.o export.o objects.o
	cc $(CFLAGS) -o nml run.o gc.o callgc.o prim.o prof.o export.o objects.o

prim.s: $(MACHINE).prim.s tags.h prof.h
	/lib/cpp $(DEFINES) $(MACHINE).prim.s > prim.s

objects.o gc.o: descriptor.h tags.h

prof.o: prof.h

clean:
	rm -f *.o lint.out prim.s

lint:
	lint $(DEFINES) run.c gc.c callgc.c prof.c export.c objects.c \
		| tee lint.out

