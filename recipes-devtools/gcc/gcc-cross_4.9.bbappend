# Add Ada to gcc-4.9.

ADA ?= ",ada"

# Check whether this works in configure, if it doesn't use .= instead!
LANGUAGES_append := "${ADA}"

FILESEXTRAPATHS_prepend := "${THISDIR}/gcc-4.9:"

#SRC_URI += "file://"

EXTRA_OECONF_INITIAL_append := "--disable-libada"

# TODO:
#  shared libs
#  multilib
#  gpr build/install class
