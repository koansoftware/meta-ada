# Add Ada to gcc-4.9.

ADA ?= ",ada"

LANGUAGES_append := "${ADA}"

EXTRA_OECONF_append := " --disable-libada"

# TODO:
#  shared libs
#  multilib
#  gpr build/install class
