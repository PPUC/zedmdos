
%-build:
	make -C buildroot O=${PWD}/output/$* BR2_EXTERNAL=${PWD} defconfig $*_defconfig
	make -C buildroot O=${PWD}/output/$* BR2_EXTERNAL=${PWD}

%-pkg:
	$(if $(PKG),,$(error "PKG not specified!"))
	make -C buildroot O=${PWD}/output/$* BR2_EXTERNAL=${PWD} $(PKG)

%-config:
	make -C buildroot O=${PWD}/output/$* BR2_EXTERNAL=${PWD} defconfig $*_defconfig
	make -C buildroot O=${PWD}/output/$* BR2_EXTERNAL=${PWD} menuconfig
