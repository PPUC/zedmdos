
%-build:
	make -C buildroot O=${PWD}/output/$* BR2_EXTERNAL=${PWD} defconfig $*_defconfig
	make -C buildroot O=${PWD}/output/$* BR2_EXTERNAL=${PWD}

%-config:
	make -C buildroot O=${PWD}/output/$* BR2_EXTERNAL=${PWD} defconfig $*_defconfig
	make -C buildroot O=${PWD}/output/$* BR2_EXTERNAL=${PWD} menuconfig
