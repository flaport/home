st:
	cd st; make clean install; cd ..

dwm:
	cd dwm; make clean install; cd ..

dmenu:
	cd dmenu; make clean install; cd ..

legacyfox:
	cd legacyfox; make clean all install; cd ..

all:
	cd st; git checkout master; git pull; make clean install; cd ..
	cd dwm; git checkout master; git pull; make clean install; cd ..
	cd dmenu; git checkout master; git pull; make clean install; cd ..
	cd legacyfox; git checkout master; git pull; make clean all install; cd ..
