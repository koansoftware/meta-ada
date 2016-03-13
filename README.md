IMPORTANT!!
-----------

I was looking into updating this layer to Jethro. Turns out this is harder than it used to be as there seems to have
been a number of changes to how Yocto builds it's toolchain.

Currently the jethro branch will build and install, correctly:

1) gnat1, the actual GNAT compiler binary into libexec.
2) gnatbind, the GNAT binder binary into bin.

The links that it sets up will also be created.

They no longer build libstdc++ inside ```gcc-cross-<arch>```, in fact they have a patch to disable it altogether. The
GNAT tools (```make gnattools```) links with this library for some unknown reason. Does this mean we need to disable
this lib in that part of the build? Currently, gnattools and libada are disabled in the gcc-cross recipe.

I looked at making gnattools and libada inside the gcc-runtime recipe, this doesn't work as the gnattools target calls
a recursive make in the base gcc directory, which isn't there. Also, in this recipe, it will build libada, but it'll
only give a static library for some unknown reason, it should give shared and static versions so they can be installed
side by side.

An alternative approach is the create a gnat recipe which completes the toolchain, by requiring the gcc*.inc files and
configuring as if we were building the full toolchain with ```--enable-libada```, but only build by calling
```make -C gcc gnatlib_and_tools```, then installing this as per usual.

Following the successful build of libada and gnattools, we need to build libgnat_util, preferably from the build gcc
sources. This could be done in the gcc-cross recipe by archiving up all the object files mentioned in gnat_util's
MANIFEST.gnat_util file, including the version.o from the gcc directory, as this contains the version symbol required
by gnatvsn package. By doing this, we avoid having to provide dummy files as is usually done and we can get real version
information from the tools.

Everything after the above is not as difficult, as it's a matter of providing recipes for the various packages, AdaCore's
and other people's work.

If you want Ada support in Yocto now and in the future, please add you comments to [this issue](https://github.com/Lucretia/meta-ada/issues/2),
don't create any new ones as I'd like to keep it all in one place. If it needs to be separated I'll do that.

Ada layer for Yocto
-------------------

This adds support for building Ada programs under Yocto. This is a work in
progress and more Ada libs will be added in future.

The main branch is for Denzil and GCC 4.6.

To build, you need a GCC that understands Ada, this causes problems for some
systems, i.e. on my Debian testing 64-bit, where the main compiler does not
understand Ada and the Ada compiler has it's own gcc/g++. I was not able to
force Yocto to build using gcc-4.6 and g++-4.6. I had to hack it by compiling
my own GCC-4.6.3 toolchain and fixing the multiarch problems with soft links
to crt[i1n].o and lib[cm].[a|so]. Any hints getting this to work would be
greatly appreciated.

** This build will not build shared libs under Yocto/Poky

See recipes-test/libhello to see how to build a library under Yocto, and see
recipes-test/hello so see how to use it under Yocto.

Debian / Ubuntu
---------------

Before building you need gnat, but as these packages are separate from the
stock gcc and also a different version, you have to make sure Yocto will
use the correct compilers. I create a new directory with links and then
export those in my path:

sudo mkdir -p /opt/gnat-4.6-links/bin
sudo cd /opt/gnat-4.6-links/bin
sudo ln -s /usr/bin/gcc-4.6 gcc
sudo ln -s /usr/bin/g++-4.6 g++
sudo ln -s /usr/bin/cpp-4.6 cpp

export PATH=/opt/gnat-4.6-links/bin:$PATH

N.B: Do not export a link to ld but using gcc-4.6 as this will fail to build
due to specific ld flags being passed into gcc which it won't understand.

If you get an error complaining that the compiler driver cannot find the
gnat1 compiler, add the following link to the above directory:

sudo ln -s /usr/lib/gcc/x86_64-linux-gnu/4.6/gnat1 gnat1

Add meta-ada into the build/conf/bblayers.conf
----------------------------------------------

  <path-to>/yocto/gumstix/poky/meta-gumstix \
  <path-to>/yocto/gumstix/poky/meta-ada \
  "

Add the following the build/conf/local.conf
-------------------------------------------

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
