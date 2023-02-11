all: build/left.uf2 build/right.uf2

setup:
	west init -l config || exit
	west update || exit
	west zephyr-export || exit

clean:
	rm -rf build

keymap: config/boards/arm/dao/dao.keymap

build/left.uf2: config/*
	west build -d build/left -s zmk/app -b dao_left -- -DZMK_CONFIG="`pwd`/config" || exit
	cp build/left/zephyr/zmk.uf2 build/left.uf2

build/right.uf2: config/*
	west build -d build/right -s zmk/app -b dao_right -- -DZMK_CONFIG="`pwd`/config" || exit
	cp build/right/zephyr/zmk.uf2 build/right.uf2

build-left: build/left.uf2

build-right: build/right.uf2

flash-left: build/left.uf2
	cp build/left.uf2 /run/media/ilutov/NRF52BOOT/

flash-right: build/right.uf2
	cp build/right.uf2 /run/media/ilutov/NRF52BOOT/

.PHONY: setup clean keymap flash-left flash-right
