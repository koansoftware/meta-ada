do_configure_append () {
	echo "Configuring gnatlib_and_tools"
	rm -rf ${B}/$target/gnatlib_and_tools/
	mkdir -p ${B}/$target/gnatlib_and_tools/
	cd ${B}/$target/gnatlib_and_tools/
}

do_compile_append () {
	cd ${B}/$target/gnatlib_and_tools/
	oe_runmake MULTIBUILDTOP=${B}/$target/gcc/ gnatlib_and_tools
}

do_install_append () {
}

PACKAGES_append = "\
    libada \
    libada-dev \
    libada-staticdev \
"

LICENSE_libada = "GPL-3.0-with-GCC-exception & GPLv3"
LICENSE_libada-dev = "GPL-3.0-with-GCC-exception & GPLv3"
LICENSE_libada-staticdev = "GPL-3.0-with-GCC-exception & GPLv3"

FILES_libada = "\
    ${libdir}/gcc/${TARGET_SYS}/${BINV}/adalib/libgnat.so.* \
    ${libdir}/gcc/${TARGET_SYS}/${BINV}/adalib/libgnarl.so.* \
"
FILES_libada-dev = "\
    ${libdir}/gcc/${TARGET_SYS}/${BINV}/adalib/libgnat.so \
    ${libdir}/gcc/${TARGET_SYS}/${BINV}/adalib/libgnarl.so \
    ${libdir}/gcc/${TARGET_SYS}/${BINV}/adalib/*.ali \
    ${libdir}/gcc/${TARGET_SYS}/${BINV}/adainclude/*.ad[sb] \
"

FILES_libada-staticdev = "\
    ${libdir}/gcc/${TARGET_SYS}/${BINV}/adalib/libgmem.a \
    ${libdir}/gcc/${TARGET_SYS}/${BINV}/adalib/libgnat.a \
    ${libdir}/gcc/${TARGET_SYS}/${BINV}/adalib/libgnarl.a \
"
