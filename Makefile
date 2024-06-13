PREFIX?=	/usr/local

CC?=		clang
CFLAGS?=	# empty
CFLAGS+=	-DHAS_NCURSES -DHAS_UNISTD -DHAS_STDARG -DHAS_STDLIB -DHAS_SYS_WAIT -DNO_CATGETS -Ofast -march=native -mtune=native -flto
PGOCFLAGS+=	-DHAS_NCURSES -DHAS_UNISTD -DHAS_STDARG -DHAS_STDLIB -DHAS_SYS_WAIT -Ofast -march=native -mtune=native -flto -fprofile-generate
#CFLAGS+=	-Wall -Wextra -pedantic
CFLAGS+=	-w
2CFLAGS+=	-DHAS_NCURSES -DHAS_UNISTD -DHAS_STDARG -DHAS_STDLIB -DHAS_SYS_WAIT -Ofast -march=native -mtune=native -flto -fprofile-use
#2CFLAGS+=	-Wall -Wextra -pedantic
2CFLAGS+=	-w

LIBS=		-lc  -v -lncursesw

PROG=		ee

all: ${PROG}

${PROG}: ${PROG}.c
	${CC} ${CFLAGS} ${PROG}.c ${LIBS} -o ${PROG}
${PROG}-PGO: ${PROG}
	${CC} ${PGOCFLAGS} ${PROG}.c ${LIBS} -o ${PROG}
	./ee 
	${CC} ${2CFLAGS} ${PROG}.c ${LIBS} -o ${PROG}

install: ${PROG}
	cp ${PROG} ${DESTDIR}${PREFIX}/bin/
	cp ${PROG}.1 ${DESTDIR}${PREFIX}/man/man1/

clean :
	rm -f ${PROG}
