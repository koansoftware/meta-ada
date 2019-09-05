# Ada layer for Yocto

This adds support for building Ada programs under Yocto. This is a work in
progress and more Ada libs will be added in future.

The "warrior" branch is an attempt to update this meta layer for Yocto 2.7.1 and
to GCC 8.3. I have not been able to build the meta-toolchain thus far,
this could be an issue with my "system" compiler, which isn't a system compiler,
but one I built using [free-ada](https://github.com/Lucretia/free-ada).

As far as I know, I'not touched Yocto for years, you still need a GCC which can
compile Ada to compile Yocto.

I have only update the gcc part, nothing else has been touched. I'm pushing here
to see if anyone can get it to work.

# TODO - Everything past this point has not been updated.

See recipes-test/libhello to see how to build a library under Yocto, and see
recipes-test/hello so see how to use it under Yocto.

# Add meta-ada into the build/conf/bblayers.conf

  <path-to>/yocto/gumstix/poky/meta-gumstix \
  <path-to>/yocto/gumstix/poky/meta-ada \
  "

# Add the following the build/conf/local.conf

# These do not build yet.
BBMASK = "gprbuild|xmlada"

# Delete the work directories after a successful build.
INHERIT = "rm_work"

# Can delete this once you have a working Yocto.
IMAGE_INSTALL_append = " hello"

# Add to the following variable to make the Ada projects available to gnatmake:
GPR_PROJECT_PATH = "${STAGING_LIBDIR}/ada/libhello"
#GPR_PROJECT_PATH .= ":${STAGING_LIBDIR}/ada/<project name>"
export GPR_PROJECT_PATH

