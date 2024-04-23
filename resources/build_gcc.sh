# Set compilers to the ones provided by Homebrew
export GMP_PREFIX=$(brew --prefix gmp)
export MPFR_PREFIX=$(brew --prefix mpfr)
export MPC_PREFIX=$(brew --prefix libmpc)

export CC=`which gcc-10`
export CXX=`which g++-10`

export CFLAGS="-I/usr/local/include/c++/10.5.0 ${CFLAGS}"
export CXXFLAGS="-I/usr/local/include/c++/10.5.0 ${CXXFLAGS}"

set -x
set -e
export WDIR=/tmp
unameOut="$(uname -srm)"
macOSver="${unameOut##* }"
export BUILD="x86_64-apple-darwin${macOSver#darwin}"  # This assumes the output includes the darwin version
export TARGET=powerpc64le-linux-gnu
export PREFIX=/opt/cross/${TARGET}
cd ${WDIR}
mkdir -p ${TARGET}-src
mkdir -p ${TARGET}-toolchain

# sed
cd ${WDIR}/${TARGET}-src
curl -L https://ftp.gnu.org/gnu/sed/sed-4.7.tar.xz | tar xJf -

cd ${WDIR}/${TARGET}-toolchain
mkdir -p build-sed
cd build-sed
${WDIR}/${TARGET}-src/sed-4.7/configure \
    --prefix=/opt/sed
make -j 8
sudo make install-strip
export PATH=/opt/sed/bin:${PATH}

# binutils
cd ${WDIR}/${TARGET}-src
curl -L http://ftp.gnu.org/gnu/binutils/binutils-2.32.tar.gz | tar xzf -

cd ${WDIR}/${TARGET}-toolchain
mkdir -p build-binutils
cd build-binutils
${WDIR}/${TARGET}-src/binutils-2.32/configure \
    --disable-nls \
    --prefix=${PREFIX} \
    --target=${TARGET}
make -j 8
sudo make install-strip
echo "export PATH=/opt/cross/powerpc64-linux-gnu/bin/:\$PATH" >> $HOME/.bash_profile

# GCC
cd ${WDIR}/${TARGET}-src
curl -L http://ftp.gnu.org/gnu/gcc/gcc-10.2.0/gcc-10.2.0.tar.xz | tar xJf -
cd ${WDIR}/${TARGET}-toolchain
mkdir -p build-gcc
cd build-gcc

${WDIR}/${TARGET}-src/gcc-10.2.0/configure \
    --target=${TARGET} \
    --prefix=${PREFIX} \
    --disable-nls \
    --enable-languages=c,c++ \
    --without-headers \
    --disable-shared \
    --disable-multilib \
    --with-gmp=$GMP_PREFIX \
    --with-mpfr=$MPFR_PREFIX \
    --with-mpc=$MPC_PREFIX

make -j 8 all-gcc
sudo make install-gcc
make -j 8 all-target-libgcc
sudo make install-target-libgcc

