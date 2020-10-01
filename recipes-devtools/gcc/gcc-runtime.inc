SUMMARY = "Runtime libraries from GCC/GNAT"

LICENSE = "GPL-3.0-with-GCC-exception"

PACKAGES += "\
    gnat-dev \
    gnat-staticdev \
    source \
"

FILES_gnat-dev = "\
  ${gcclibdir}/${TARGET_SYS}/${BINV}/adalib/lib*.so \
"

SUMMARY_gnat-dev = "GNU Ada Translator Runtime Library"

FILES_gnat-staticdev = "\
  ${gcclibdir}/${TARGET_SYS}/${BINV}/adalib/*.ali \
  ${gcclibdir}/${TARGET_SYS}/${BINV}/adalib/lib*.a \
"

SUMMARY_gnat-staticdev = "GNU Ada Translator Runtime Library - static development files"

FILES_gnat-source = "\
  ${gcclibdir}/${TARGET_SYS}/${BINV}/adainclude/*.ad[sb] \
"

SUMMARY_gnat-source = "GNU Ada Translator Runtime Library - source files"
