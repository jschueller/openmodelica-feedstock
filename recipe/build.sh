#!/bin/sh

set -x

cmake ${CMAKE_ARGS} -G "Ninja" -LAH \
  -DOM_ENABLE_GUI_CLIENTS=ON -DOM_QT_MAJOR_VERSION=5 -DOM_OMEDIT_ENABLE_QTWEBENGINE=ON \
  -DOM_OMC_ENABLE_FORTRAN=ON -DOM_OMC_ENABLE_OPTIMIZATION=ON -DOM_OMC_ENABLE_MOO=ON \
  -DOM_USE_CCACHE=OFF \
  -DOM_USE_SYSTEM_LIBFFI=ON \
  -DOM_USE_SYSTEM_ZLIB=ON \
  -DOM_MACOS_APP_BUNDLE=OFF \
  -B build -S .
cmake --build build --target install --parallel ${CPU_COUNT}

# https://github.com/OpenModelica/OpenModelica/issues/16649
test `uname` = "Linux" && rm ${PREFIX}/include/omc/omsicpp/Core/Modelica.h.gch
test ! -f ${PREFIX}/include/omc/omsicpp/Core/Modelica.h.gch
