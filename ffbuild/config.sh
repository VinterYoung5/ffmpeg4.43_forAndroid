# Automatically generated by configure - do not modify!
shared=yes
build_suffix=
prefix=/mnt/e/code/tf10/vendor/flyme/frameworks/media/ffmpeg4android/ffmpeg4.43_forAndroid/android/aarch64
libdir=${prefix}/lib
incdir=${prefix}/include
rpath=
source_path=.
LIBPREF=lib
LIBSUF=.a
extralibs_avutil="-pthread -lm -latomic"
extralibs_avcodec="-pthread -lm -latomic"
extralibs_avformat="-lm -latomic -lz"
extralibs_avdevice="-lm -latomic"
extralibs_avfilter="-pthread -lm -latomic"
extralibs_avresample="-lm"
extralibs_postproc="-lm -latomic"
extralibs_swscale="-lm -latomic"
extralibs_swresample="-lm -latomic"
avdevice_deps="avformat avcodec swresample avutil"
avfilter_deps="avutil"
swscale_deps="avutil"
postproc_deps="avutil"
avformat_deps="avcodec swresample avutil"
avcodec_deps="swresample avutil"
swresample_deps="avutil"
avresample_deps="avutil"
avutil_deps=""
