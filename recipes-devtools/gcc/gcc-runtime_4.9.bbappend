RUNTIMETARGET_append := " libada gnattools"

ADA ?= ",ada"

LANGUAGES_append := "${ADA}"

do_compile_prepend () {
#	export CC="${BUILD_CC}"
	export AR_FOR_TARGET="${TARGET_SYS}-ar"
	export RANLIB_FOR_TARGET="${TARGET_SYS}-ranlib"
#	export LD_FOR_TARGET="${TARGET_SYS}-ld"
	export NM_FOR_TARGET="${TARGET_SYS}-nm"
#	export CC_FOR_TARGET="${CCACHE} ${TARGET_SYS}-gcc"
#	export CFLAGS_FOR_TARGET="${TARGET_CFLAGS}"
#	export CPPFLAGS_FOR_TARGET="${TARGET_CPPFLAGS}"
#	export CXXFLAGS_FOR_TARGET="${TARGET_CXXFLAGS}"
#	export LDFLAGS_FOR_TARGET="${TARGET_LDFLAGS}"
}

#do_configure_append () {
#	echo "Configuring gnatlib_and_tools"
#	rm -rf ${B}/$target/gnatlib_and_tools/
#	mkdir -p ${B}/$target/gnatlib_and_tools/
#	cd ${B}/$target/gnatlib_and_tools/
#}

#do_compile_append () {
#	cd ${B}/$target/gnatlib_and_tools/
#	oe_runmake -C ${B}/$target/../gcc/ gnatlib
#}

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
