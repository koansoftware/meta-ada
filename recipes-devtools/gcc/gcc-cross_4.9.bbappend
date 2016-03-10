# Add Ada to gcc-4.9.

ADA ?= ",ada"

LANGUAGES_append := "${ADA}"

EXTRA_OECONF_append := " --disable-libada"

do_install_append () {
	dest=${D}${libexecdir}/gcc/${TARGET_SYS}/${BINV}/
	for t in gnatbind; do
		ln -sf ${BINRELPATH}/${TARGET_PREFIX}$t $dest$t
		ln -sf ${BINRELPATH}/${TARGET_PREFIX}$t ${dest}${TARGET_PREFIX}$t
	done
}

# TODO:
#  shared libs
#  multilib
#  gpr build/install class
