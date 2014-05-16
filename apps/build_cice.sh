#!/bin/bash
set -x

workingdir=${PWD} 
cd ../
metroms_base=${PWD} 
cd ../
tup=${PWD}

# Build CICE
mkdir -p ${tup}/tmproms
cd ${tup}/tmproms
# Unpack standard source files
tar -xf ${metroms_base}/static_libs/cice5.tar.gz
export CICE_DIR=${tup}/tmproms/cice
cd $CICE_DIR

export MCT_INCDIR=${tup}/tmproms/roms_src/Lib/MCT/include
export MCT_LIBDIR=${tup}/tmproms/roms_src/Lib/MCT/lib


# Copy modified source files
cp -auv $workingdir/common/modified_src/cice ${tup}/tmproms

# Remove old binaries
rm -rf ${tup}/tmproms/cice/rundir/compile

./comp_ice

# Build a library (for use in the ROMS build)
cd $CICE_DIR/rundir/compile
ar rcv libcice.a *.o

cp $workingdir/common/modified_src/cice/input_templates/ice_in ${tup}/tmproms/cice/rundir/

set +x