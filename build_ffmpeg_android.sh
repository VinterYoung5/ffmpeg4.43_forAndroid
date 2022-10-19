#!/bin/bash
if ["$NDK_HOME" == ""]
then
	export NDK_HOME=./../android-ndk-r20b
	echo NDK variable not set , assuming ${NDK_HOME}
fi

HOST_TAG=linux-x86_64
TOOLCHAIN=$NDK_HOME/toolchains/llvm/prebuilt/$HOST_TAG
API=29

configure()
{
	CPU=$1
	PREFIX=`pwd`/android/$CPU
	ARCH=""
	SYSROOT=""
	CROSS_PREFIX=""
	CC=""
	CXX=""
	EXTRA_CFLAGS=""
	EXTRA_LDFLAGS=""
	EXTRA_LIBS=""

	if [ "$CPU" = "armv7a" ]
	then
		ARCH=arm
		SYSROOT=$TOOLCHAIN/sysroot
		CROSS_PREFIX=$TOOLCHAIN/bin/arm-linux-androideabi-
		CC=$TOOLCHAIN/bin/armv7a-linux-androideabi$API-clang
		CXX=$TOOLCHAIN/bin/armv7a-linux-androideabi$API-clang++
		EXTRA_CFLAGS="-march=armv7-a -marm -mtune=cortex-a8 -mfloat-abi=softfp -mfpu=neon "
	else
		ARCH=aarch64
		SYSROOT=$TOOLCHAIN/sysroot
		CROSS_PREFIX=$TOOLCHAIN/bin/aarch64-linux-android-
		CC=$TOOLCHAIN/bin/aarch64-linux-android$API-clang
		CXX=$TOOLCHAIN/bin/aarch64-linux-android$API-clang++
		EXTRA_CFLAGS="-march=armv8-a "
	fi

CONFIG_FLAG="--target-os=android \
--prefix=$PREFIX \
--arch=$ARCH \
--sysroot=$SYSROOT \
--cross-prefix=$CROSS_PREFIX \
--cc=$CC \
--cxx=$CXX \
--enable-cross-compile \
--enable-shared \
--enable-neon \
--enable-pic \
--enable-asm \
--disable-ffmpeg \
--disable-ffplay \
--disable-ffprobe \
--disable-static \
--disable-network \
--disable-doc \
--disable-symver \
--disable-avdevice \
--disable-avfilter \
--disable-devices \
--disable-filters \
--disable-encoders \
--disable-muxers \
--disable-decoders \
--enable-decoder=aac \
--enable-decoder=aac_fixed \
--enable-decoder=aac_latm \
--disable-decoder=aasc \
--enable-decoder=ac3 \
--enable-decoder=ac3_fixed \
--disable-decoder=acelp_kelvin \
--disable-decoder=adpcm_4xm \
--disable-decoder=adpcm_adx \
--disable-decoder=adpcm_afc \
--disable-decoder=adpcm_agm \
--disable-decoder=adpcm_aica \
--disable-decoder=adpcm_argo \
--disable-decoder=adpcm_ct \
--disable-decoder=adpcm_dtk \
--disable-decoder=adpcm_ea \
--disable-decoder=adpcm_ea_maxis_xa \
--disable-decoder=adpcm_ea_r1 \
--disable-decoder=adpcm_ea_r2 \
--disable-decoder=adpcm_ea_r3 \
--disable-decoder=adpcm_ea_xas \
--disable-decoder=adpcm_g722 \
--disable-decoder=adpcm_g726 \
--disable-decoder=adpcm_g726le \
--disable-decoder=adpcm_ima_acorn \
--disable-decoder=adpcm_ima_alp \
--disable-decoder=adpcm_ima_amv \
--disable-decoder=adpcm_ima_apc \
--disable-decoder=adpcm_ima_apm \
--disable-decoder=adpcm_ima_cunning \
--disable-decoder=adpcm_ima_dat4 \
--disable-decoder=adpcm_ima_dk3 \
--disable-decoder=adpcm_ima_dk4 \
--disable-decoder=adpcm_ima_ea_eacs \
--disable-decoder=adpcm_ima_ea_sead \
--disable-decoder=adpcm_ima_iss \
--disable-decoder=adpcm_ima_moflex \
--disable-decoder=adpcm_ima_mtf \
--disable-decoder=adpcm_ima_oki \
--disable-decoder=adpcm_ima_qt \
--disable-decoder=adpcm_ima_rad \
--disable-decoder=adpcm_ima_smjpeg \
--disable-decoder=adpcm_ima_ssi \
--disable-decoder=adpcm_ima_wav \
--disable-decoder=adpcm_ima_ws \
--disable-decoder=adpcm_ms \
--disable-decoder=adpcm_mtaf \
--disable-decoder=adpcm_psx \
--disable-decoder=adpcm_sbpro_2 \
--disable-decoder=adpcm_sbpro_3 \
--disable-decoder=adpcm_sbpro_4 \
--disable-decoder=adpcm_swf \
--disable-decoder=adpcm_thp \
--disable-decoder=adpcm_thp_le \
--disable-decoder=adpcm_vima \
--disable-decoder=adpcm_xa \
--disable-decoder=adpcm_yamaha \
--disable-decoder=adpcm_zork \
--disable-decoder=agm \
--disable-decoder=aic \
--enable-decoder=alac \
--disable-decoder=alias_pix \
--disable-decoder=als \
--enable-decoder=amrnb \
--enable-decoder=amrwb \
--disable-decoder=amv \
--disable-decoder=anm \
--disable-decoder=ansi \
--enable-decoder=ape \
--disable-decoder=apng \
--disable-decoder=aptx \
--disable-decoder=aptx_hd \
--disable-decoder=arbc \
--disable-decoder=argo \
--disable-decoder=ass \
--disable-decoder=asv1 \
--disable-decoder=asv2 \
--disable-decoder=atrac1 \
--disable-decoder=atrac3 \
--disable-decoder=atrac3al \
--disable-decoder=atrac3p \
--disable-decoder=atrac3pal \
--disable-decoder=atrac9 \
--disable-decoder=aura \
--disable-decoder=aura2 \
--enable-decoder=av1 \
--disable-decoder=avrn \
--disable-decoder=avrp \
--enable-decoder=avs \
--disable-decoder=avui \
--disable-decoder=ayuv \
--disable-decoder=bethsoftvid \
--disable-decoder=bfi \
--disable-decoder=bink \
--disable-decoder=binkaudio_dct \
--disable-decoder=binkaudio_rdft \
--disable-decoder=bintext \
--disable-decoder=bitpacked \
--enable-decoder=bmp \
--disable-decoder=bmv_audio \
--disable-decoder=bmv_video \
--disable-decoder=brender_pix \
--disable-decoder=c93 \
--disable-decoder=cavs \
--disable-decoder=ccaption \
--disable-decoder=cdgraphics \
--disable-decoder=cdtoons \
--disable-decoder=cdxl \
--disable-decoder=cfhd \
--disable-decoder=cinepak \
--disable-decoder=clearvideo \
--disable-decoder=cljr \
--disable-decoder=cllc \
--disable-decoder=comfortnoise \
--disable-decoder=cook \
--disable-decoder=cpia \
--disable-decoder=cri \
--disable-decoder=cscd \
--disable-decoder=cyuv \
--disable-decoder=dca \
--disable-decoder=dds \
--disable-decoder=derf_dpcm \
--disable-decoder=dfa \
--disable-decoder=dfpwm \
--enable-decoder=dirac \
--disable-decoder=dnxhd \
--disable-decoder=dolby_e \
--disable-decoder=dpx \
--disable-decoder=dsd_lsbf \
--disable-decoder=dsd_lsbf_planar \
--disable-decoder=dsd_msbf \
--disable-decoder=dsd_msbf_planar \
--disable-decoder=dsicinaudio \
--disable-decoder=dsicinvideo \
--disable-decoder=dss_sp \
--disable-decoder=dst \
--disable-decoder=dvaudio \
--disable-decoder=dvbsub \
--disable-decoder=dvdsub \
--enable-decoder=dvvideo \
--disable-decoder=dxa \
--disable-decoder=dxtory \
--disable-decoder=dxv \
--enable-decoder=eac3 \
--disable-decoder=eacmv \
--disable-decoder=eamad \
--disable-decoder=eatgq \
--disable-decoder=eatgv \
--disable-decoder=eatqi \
--disable-decoder=eightbps \
--disable-decoder=eightsvx_exp \
--disable-decoder=eightsvx_fib \
--disable-decoder=escape124 \
--disable-decoder=escape130 \
--disable-decoder=evrc \
--disable-decoder=exr \
--enable-decoder=fastaudio \
--disable-decoder=ffv1 \
--disable-decoder=ffvhuff \
--disable-decoder=ffwavesynth \
--disable-decoder=fic \
--disable-decoder=fits \
--enable-decoder=flac \
--disable-decoder=flashsv \
--disable-decoder=flashsv2 \
--enable-decoder=flic \
--enable-decoder=flv \
--disable-decoder=fmvc \
--disable-decoder=fourxm \
--disable-decoder=fraps \
--disable-decoder=frwu \
--disable-decoder=g2m \
--disable-decoder=g723_1 \
--disable-decoder=g729 \
--disable-decoder=gdv \
--disable-decoder=gem \
--enable-decoder=gif \
--disable-decoder=gremlin_dpcm \
--disable-decoder=gsm \
--disable-decoder=gsm_ms \
--enable-decoder=h261 \
--enable-decoder=h263 \
--enable-decoder=h263_v4l2m2m \
--enable-decoder=h263i \
--enable-decoder=h263p \
--enable-decoder=h264 \
--enable-decoder=h264_v4l2m2m \
--disable-decoder=hap \
--disable-decoder=hca \
--disable-decoder=hcom \
--enable-decoder=hevc \
--enable-decoder=hevc_v4l2m2m \
--disable-decoder=hnm4_video \
--disable-decoder=hq_hqa \
--disable-decoder= \
--disable-decoder=hqx \
--disable-decoder=huffyuv \
--disable-decoder=hymt \
--disable-decoder=iac \
--disable-decoder=idcin \
--disable-decoder=idf \
--disable-decoder=iff_ilbm \
--disable-decoder=ilbc \
--disable-decoder=imc \
--disable-decoder=imm4 \
--disable-decoder=imm5 \
--disable-decoder=indeo2 \
--disable-decoder=indeo3 \
--disable-decoder=indeo4 \
--disable-decoder=indeo5 \
--disable-decoder=interplay_acm \
--disable-decoder=interplay_dpcm \
--disable-decoder=interplay_video \
--disable-decoder=ipu \
--disable-decoder=jacosub \
--enable-decoder=jpeg2000 \
--disable-decoder=jpegls \
--disable-decoder=jv \
--disable-decoder=kgv1 \
--disable-decoder=kmvc \
--disable-decoder=lagarith \
--disable-decoder=loco \
--disable-decoder=lscr \
--disable-decoder=m101 \
--disable-decoder=mace3 \
--disable-decoder=mace6 \
--disable-decoder=magicyuv \
--disable-decoder=mdec \
--disable-decoder=metasound \
--disable-decoder=microdvd \
--disable-decoder=mimic \
--enable-decoder=mjpeg \
--disable-decoder=mjpegb \
--disable-decoder=mlp \
--disable-decoder=mmvideo \
--disable-decoder=mobiclip \
--disable-decoder=motionpixels \
--disable-decoder=movtext \
--enable-decoder=mp1 \
--enable-decoder=mp1float \
--enable-decoder=mp2 \
--enable-decoder=mp2float \
--enable-decoder=mp3 \
--enable-decoder=mp3adu \
--enable-decoder=mp3adufloat \
--enable-decoder=mp3float \
--enable-decoder=mp3on4 \
--enable-decoder=mp3on4float \
--disable-decoder=mpc7 \
--disable-decoder=mpc8 \
--enable-decoder=mpeg1_v4l2m2m \
--enable-decoder=mpeg1video \
--enable-decoder=mpeg2_v4l2m2m \
--enable-decoder=mpeg2video \
--enable-decoder=mpeg4 \
--enable-decoder=mpeg4_v4l2m2m \
--enable-decoder=mpegvideo \
--enable-decoder=mpl2 \
--disable-decoder=msa1 \
--disable-decoder=mscc \
--disable-decoder=msmpeg4v1 \
--disable-decoder=msmpeg4v2 \
--disable-decoder=msmpeg4v3 \
--disable-decoder=msnsiren \
--disable-decoder=msp2 \
--disable-decoder=msrle \
--disable-decoder=mss1 \
--disable-decoder=mss2 \
--disable-decoder=msvideo1 \
--disable-decoder=mszh \
--disable-decoder=mts2 \
--disable-decoder=mv30 \
--disable-decoder=mvc1 \
--disable-decoder=mvc2 \
--disable-decoder=mvdv \
--disable-decoder=mvha \
--disable-decoder=mwsc \
--disable-decoder=mxpeg \
--disable-decoder=nellymoser \
--disable-decoder=notchlc \
--disable-decoder=nuv \
--disable-decoder=on2avc \
--enable-decoder=opus \
--disable-decoder=paf_audio \
--disable-decoder=paf_video \
--disable-decoder=pam \
--disable-decoder=pbm \
--enable-decoder=pcm_alaw \
--enable-decoder=pcm_bluray \
--enable-decoder=pcm_dvd \
--enable-decoder=pcm_f16le \
--enable-decoder=pcm_f24le \
--enable-decoder=pcm_f32be \
--enable-decoder=pcm_f32le \
--enable-decoder=pcm_f64be \
--enable-decoder=pcm_f64le \
--disable-decoder=pcm_lxf \
--disable-decoder=pcm_mulaw \
--enable-decoder=pcm_s16be \
--enable-decoder=pcm_s16be_planar \
--enable-decoder=pcm_s16le \
--enable-decoder=pcm_s16le_planar \
--enable-decoder=pcm_s24be \
--enable-decoder=pcm_s24daud \
--enable-decoder=pcm_s24le \
--enable-decoder=pcm_s24le_planar \
--enable-decoder=pcm_s32be \
--enable-decoder=pcm_s32le \
--enable-decoder=pcm_s32le_planar \
--enable-decoder=pcm_s64be \
--enable-decoder=pcm_s64le \
--enable-decoder=pcm_s8 \
--enable-decoder=pcm_s8_planar \
--enable-decoder=pcm_sga \
--enable-decoder=pcm_u16be \
--enable-decoder=pcm_u16le \
--enable-decoder=pcm_u24be \
--enable-decoder=pcm_u24le \
--enable-decoder=pcm_u32be \
--enable-decoder=pcm_u32le \
--enable-decoder=pcm_u8 \
--enable-decoder=pcm_vidc \
--disable-decoder=pcx \
--disable-decoder=pfm \
--disable-decoder=pgm \
--disable-decoder=pgmyuv \
--disable-decoder=pgssub \
--disable-decoder=pgx \
--disable-decoder=phm \
--disable-decoder=photocd \
--disable-decoder=pictor \
--disable-decoder=pixlet \
--disable-decoder=pjs \
--disable-decoder=png \
--disable-decoder=ppm \
--disable-decoder=prores \
--disable-decoder=prosumer \
--disable-decoder=psd \
--disable-decoder=ptx \
--disable-decoder=qcelp \
--disable-decoder=qdm2 \
--disable-decoder=qdmc \
--disable-decoder=qdraw \
--disable-decoder=qoi \
--disable-decoder=qpeg \
--disable-decoder=qtrle \
--disable-decoder=r10k \
--disable-decoder=r210 \
--disable-decoder=ra_144 \
--disable-decoder=ra_288 \
--disable-decoder=ralf \
--disable-decoder=rasc \
--disable-decoder=rawvideo \
--disable-decoder=realtext \
--disable-decoder=rl2 \
--disable-decoder=roq \
--disable-decoder=roq_dpcm \
--disable-decoder=rpza \
--disable-decoder=rscc \
--enable-decoder=rv10 \
--enable-decoder=rv20 \
--enable-decoder=rv30 \
--enable-decoder=rv40 \
--disable-decoder=s302m \
--disable-decoder=sami \
--disable-decoder=sanm \
--disable-decoder=sbc \
--disable-decoder=scpr \
--disable-decoder=screenpresso \
--disable-decoder=sdx2_dpcm \
--disable-decoder=sga \
--disable-decoder=sgi \
--disable-decoder=sgirle \
--disable-decoder=sheervideo \
--disable-decoder=shorten \
--disable-decoder=simbiosis_imx \
--disable-decoder=sipr \
--disable-decoder=siren \
--disable-decoder=smackaud \
--disable-decoder=smacker \
--disable-decoder=smc \
--disable-decoder=smvjpeg \
--disable-decoder=snow \
--disable-decoder=sol_dpcm \
--disable-decoder=sonic \
--disable-decoder=sp5x \
--disable-decoder=speedhq \
--disable-decoder=speex \
--disable-decoder=srgc \
--disable-decoder=srt \
--disable-decoder=ssa \
--disable-decoder=stl \
--disable-decoder=subrip \
--disable-decoder=subviewer \
--disable-decoder=subviewer1 \
--disable-decoder=sunrast \
--disable-decoder=svq1 \
--disable-decoder=svq3 \
--disable-decoder=tak \
--disable-decoder=targa \
--disable-decoder=targa_y216 \
--disable-decoder=tdsc \
--disable-decoder=text \
--disable-decoder=theora \
--disable-decoder=thp \
--disable-decoder=tiertexseqvideo \
--disable-decoder=tiff \
--disable-decoder=tmv \
--disable-decoder=truehd \
--disable-decoder=truemotion1 \
--disable-decoder=truemotion2 \
--disable-decoder=truemotion2rt \
--disable-decoder=truespeech \
--disable-decoder=tscc \
--disable-decoder=tscc2 \
--disable-decoder=tta \
--disable-decoder=twinvq \
--disable-decoder=txd \
--disable-decoder=ulti \
--disable-decoder=utvideo \
--disable-decoder=v210 \
--disable-decoder=v210x \
--disable-decoder=v308 \
--disable-decoder=v408 \
--disable-decoder=v410 \
--disable-decoder=vb \
--disable-decoder=vble \
--disable-decoder=vbn \
--enable-decoder=vc1 \
--enable-decoder=vc1_v4l2m2m \
--enable-decoder=vc1image \
--disable-decoder=vcr1 \
--disable-decoder=vmdaudio \
--disable-decoder=vmdvideo \
--disable-decoder=vmnc \
--disable-decoder=vorbis \
--disable-decoder=vp3 \
--disable-decoder=vp4 \
--disable-decoder=vp5 \
--enable-decoder=vp6 \
--enable-decoder=vp6a \
--enable-decoder=vp6f \
--enable-decoder=vp7 \
--enable-decoder=vp8 \
--enable-decoder=vp8_v4l2m2m \
--enable-decoder=vp9 \
--enable-decoder=vp9_v4l2m2m \
--disable-decoder=vplayer \
--disable-decoder=vqa \
--disable-decoder=wavpack \
--disable-decoder=wcmv \
--enable-decoder=webp \
--disable-decoder=webvtt \
--disable-decoder=wmalossless \
--disable-decoder=wmapro \
--disable-decoder=wmav1 \
--disable-decoder=wmav2 \
--disable-decoder=wmavoice \
--enable-decoder=wmv1 \
--enable-decoder=wmv2 \
--enable-decoder=wmv3 \
--enable-decoder=wmv3image \
--disable-decoder=wnv1 \
--disable-decoder=wrapped_avframe \
--disable-decoder=ws_snd1 \
--disable-decoder=xan_dpcm \
--disable-decoder=xan_wc3 \
--disable-decoder=xan_wc4 \
--disable-decoder=xbin \
--disable-decoder=xbm \
--disable-decoder=xface \
--disable-decoder=xl \
--disable-decoder=xma1 \
--disable-decoder=xma2 \
--disable-decoder=xpm \
--disable-decoder=xsub \
--disable-decoder=xwd \
--disable-decoder=y41p \
--disable-decoder=ylc \
--disable-decoder=yop \
--disable-decoder=yuv4 \
--disable-decoder=zero12v \
--disable-decoder=zerocodec \
--disable-decoder=zlib \
--disable-decoder=zmbv \
--disable-parsers \
--disable-demuxers \
--disable-demuxer=aa \
--enable-demuxer=aac \
--disable-demuxer=aax \
--enable-demuxer=ac3 \
--disable-demuxer=ace \
--disable-demuxer=acm \
--disable-demuxer=act \
--disable-demuxer=adf \
--disable-demuxer=adp \
--disable-demuxer=ads \
--disable-demuxer=adx \
--disable-demuxer=aea \
--disable-demuxer=afc \
--disable-demuxer=aiff \
--disable-demuxer=aix \
--disable-demuxer=alp \
--enable-demuxer=amr \
--enable-demuxer=amrnb \
--enable-demuxer=amrwb \
--disable-demuxer=anm \
--disable-demuxer=apc \
--enable-demuxer=ape \
--disable-demuxer=apm \
--disable-demuxer=apng \
--disable-demuxer=aptx \
--disable-demuxer=aptx_hd \
--disable-demuxer=aqtitle \
--disable-demuxer=argo_asf \
--disable-demuxer=argo_brp \
--disable-demuxer=argo_cvg \
--enable-demuxer=asf \
--enable-demuxer=asf_o \
--disable-demuxer=ass \
--disable-demuxer=ast \
--disable-demuxer=au \
--enable-demuxer=av1 \
--enable-demuxer=avi \
--disable-demuxer=avr \
--enable-demuxer=avs \
--enable-demuxer=avs2 \
--enable-demuxer=avs3 \
--disable-demuxer=bethsoftvid \
--disable-demuxer=bfi \
--disable-demuxer=bfstm \
--disable-demuxer=bink \
--disable-demuxer=binka \
--disable-demuxer=bintext \
--disable-demuxer=bit \
--disable-demuxer=bitpacked \
--disable-demuxer=bmv \
--disable-demuxer=boa \
--disable-demuxer=brstm \
--disable-demuxer=c93 \
--disable-demuxer=caf \
--disable-demuxer=cavsvideo \
--disable-demuxer=cdg \
--disable-demuxer=cdxl \
--disable-demuxer=cine \
--disable-demuxer=codec2 \
--disable-demuxer=codec2raw \
--disable-demuxer=concat \
--disable-demuxer=data \
--disable-demuxer=daud \
--disable-demuxer=dcstr \
--disable-demuxer=derf \
--disable-demuxer=dfa \
--disable-demuxer=dfpwm \
--disable-demuxer=dhav \
--disable-demuxer=dirac \
--disable-demuxer=dnxhd \
--disable-demuxer=dsf \
--disable-demuxer=dsicin \
--disable-demuxer=dss \
--disable-demuxer=dts \
--disable-demuxer=dtshd \
--disable-demuxer=dv \
--disable-demuxer=dvbsub \
--disable-demuxer=dvbtxt \
--disable-demuxer=dxa \
--disable-demuxer=ea \
--disable-demuxer=ea_cdata \
--disable-demuxer=eac3 \
--disable-demuxer=epaf \
--disable-demuxer=ffmetadata \
--disable-demuxer=filmstrip \
--disable-demuxer=fits \
--enable-demuxer=flac \
--disable-demuxer=flic \
--enable-demuxer=flv \
--disable-demuxer=fourxm \
--disable-demuxer=frm \
--disable-demuxer=fsb \
--disable-demuxer=fwse \
--disable-demuxer=g722 \
--disable-demuxer=g723_1 \
--disable-demuxer=g726 \
--disable-demuxer=g726le \
--disable-demuxer=g729 \
--disable-demuxer=gdv \
--disable-demuxer=genh \
--enable-demuxer=gif \
--disable-demuxer=gsm \
--disable-demuxer=gxf \
--disable-demuxer=h261 \
--enable-demuxer=h263 \
--enable-demuxer=h264 \
--disable-demuxer=hca \
--disable-demuxer=hcom \
--enable-demuxer=hevc \
--enable-demuxer=hls \
--disable-demuxer=hnm \
--disable-demuxer=ico \
--disable-demuxer=idcin \
--disable-demuxer=idf \
--disable-demuxer=iff \
--enable-demuxer=ifv \
--disable-demuxer=ilbc \
--disable-demuxer=image2 \
--disable-demuxer=image2_alias_pix \
--disable-demuxer=image2_brender_pix \
--disable-demuxer=image2pipe \
--disable-demuxer=image_bmp_pipe \
--disable-demuxer=image_cri_pipe \
--disable-demuxer=image_dds_pipe \
--disable-demuxer=image_dpx_pipe \
--disable-demuxer=image_exr_pipe \
--disable-demuxer=image_gem_pipe \
--disable-demuxer=image_gif_pipe \
--disable-demuxer=image_j2k_pipe \
--disable-demuxer=image_jpeg_pipe \
--disable-demuxer=image_jpegls_pipe \
--disable-demuxer=image_jpegxl_pipe \
--disable-demuxer=image_pam_pipe \
--disable-demuxer=image_pbm_pipe \
--disable-demuxer=image_pcx_pipe \
--disable-demuxer=image_pfm_pipe \
--disable-demuxer=image_pgm_pipe \
--disable-demuxer=image_pgmyuv_pipe \
--disable-demuxer=image_pgx_pipe \
--disable-demuxer=image_phm_pipe \
--disable-demuxer=image_photocd_pipe \
--disable-demuxer=image_pictor_pipe \
--disable-demuxer=image_png_pipe \
--disable-demuxer=image_ppm_pipe \
--disable-demuxer=image_psd_pipe \
--disable-demuxer=image_qdraw_pipe \
--disable-demuxer=image_qoi_pipe \
--disable-demuxer=image_sgi_pipe \
--disable-demuxer=image_sunrast_pipe \
--disable-demuxer=image_svg_pipe \
--disable-demuxer=image_tiff_pipe \
--disable-demuxer=image_vbn_pipe \
--disable-demuxer=image_webp_pipe \
--disable-demuxer=image_xbm_pipe \
--disable-demuxer=image_xpm_pipe \
--disable-demuxer=image_xwd_pipe \
--disable-demuxer=ingenient \
--disable-demuxer=ipmovie \
--disable-demuxer=ipu \
--disable-demuxer=ircam \
--disable-demuxer=iss \
--enable-demuxer=iv8 \
--enable-demuxer=ivf \
--disable-demuxer=ivr \
--disable-demuxer=jacosub \
--disable-demuxer=jv \
--disable-demuxer=kux \
--disable-demuxer=kvag \
--disable-demuxer=live_flv \
--disable-demuxer=lmlm4 \
--disable-demuxer=loas \
--disable-demuxer=lrc \
--disable-demuxer=luodat \
--disable-demuxer=lvf \
--disable-demuxer=lxf \
--enable-demuxer=m4v \
--enable-demuxer=matroska \
--disable-demuxer=mca \
--disable-demuxer=mcc \
--disable-demuxer=mgsts \
--disable-demuxer=microdvd \
--enable-demuxer=mjpeg \
--enable-demuxer=mjpeg_2000 \
--disable-demuxer=mlp \
--disable-demuxer=mlv \
--disable-demuxer=mm \
--disable-demuxer=mmf \
--disable-demuxer=mods \
--disable-demuxer=moflex \
--enable-demuxer=mov \
--enable-demuxer=mp3 \
--disable-demuxer=mpc \
--disable-demuxer=mpc8 \
--enable-demuxer=mpegps \
--enable-demuxer=mpegts \
--enable-demuxer=mpegtsraw \
--enable-demuxer=mpegvideo \
--enable-demuxer=mpjpeg \
--enable-demuxer=mpl2 \
--disable-demuxer=mpsub \
--disable-demuxer=msf \
--disable-demuxer=msnwc_tcp \
--disable-demuxer=msp \
--disable-demuxer=mtaf \
--disable-demuxer=mtv \
--disable-demuxer=musx \
--disable-demuxer=mv \
--disable-demuxer=mvi \
--disable-demuxer=mxf \
--disable-demuxer=mxg \
--disable-demuxer=nc \
--disable-demuxer=nistsphere \
--disable-demuxer=nsp \
--disable-demuxer=nsv \
--disable-demuxer=nut \
--disable-demuxer=nuv \
--disable-demuxer=obu \
--enable-demuxer=ogg \
--disable-demuxer=oma \
--disable-demuxer=paf \
--disable-demuxer=pcm_alaw \
--disable-demuxer=pcm_f32be \
--disable-demuxer=pcm_f32le \
--disable-demuxer=pcm_f64be \
--disable-demuxer=pcm_f64le \
--disable-demuxer=pcm_mulaw \
--disable-demuxer=pcm_s16be \
--disable-demuxer=pcm_s16le \
--disable-demuxer=pcm_s24be \
--disable-demuxer=pcm_s24le \
--disable-demuxer=pcm_s32be \
--disable-demuxer=pcm_s32le \
--disable-demuxer=pcm_s8 \
--disable-demuxer=pcm_u16be \
--disable-demuxer=pcm_u16le \
--disable-demuxer=pcm_u24be \
--disable-demuxer=pcm_u24le \
--disable-demuxer=pcm_u32be \
--disable-demuxer=pcm_u32le \
--disable-demuxer=pcm_u8 \
--disable-demuxer=pcm_vidc \
--disable-demuxer=pjs \
--disable-demuxer=pmp \
--disable-demuxer=pp_bnk \
--disable-demuxer=pva \
--disable-demuxer=pvf \
--disable-demuxer=qcp \
--disable-demuxer=r3d \
--disable-demuxer=rawvideo \
--disable-demuxer=realtext \
--disable-demuxer=redspark \
--disable-demuxer=rl2 \
--disable-demuxer=rm \
--disable-demuxer=roq \
--disable-demuxer=rpl \
--disable-demuxer=rsd \
--disable-demuxer=rso \
--disable-demuxer=s337m \
--disable-demuxer=sami \
--disable-demuxer=sbc \
--disable-demuxer=sbg \
--disable-demuxer=scc \
--disable-demuxer=scd \
--disable-demuxer=sdr2 \
--disable-demuxer=sds \
--disable-demuxer=sdx \
--disable-demuxer=segafilm \
--disable-demuxer=ser \
--disable-demuxer=sga \
--disable-demuxer=shorten \
--disable-demuxer=siff \
--disable-demuxer=simbiosis_imx \
--disable-demuxer=sln \
--disable-demuxer=smacker \
--disable-demuxer=smjpeg \
--disable-demuxer=smush \
--disable-demuxer=sol \
--disable-demuxer=sox \
--disable-demuxer=spdif \
--disable-demuxer=srt \
--disable-demuxer=stl \
--disable-demuxer=str \
--disable-demuxer=subviewer \
--disable-demuxer=subviewer1 \
--disable-demuxer=sup \
--disable-demuxer=svag \
--disable-demuxer=svs \
--disable-demuxer=swf \
--disable-demuxer=tak \
--disable-demuxer=tedcaptions \
--disable-demuxer=thp \
--disable-demuxer=threedostr \
--disable-demuxer=tiertexseq \
--disable-demuxer=tmv \
--disable-demuxer=truehd \
--disable-demuxer=tta \
--disable-demuxer=tty \
--disable-demuxer=txd \
--disable-demuxer=ty \
--disable-demuxer=v210 \
--disable-demuxer=v210x \
--disable-demuxer=vag \
--enable-demuxer=vc1 \
--enable-demuxer=vc1t \
--disable-demuxer=vividas \
--disable-demuxer=vivo \
--disable-demuxer=vmd \
--disable-demuxer=vobsub \
--disable-demuxer=voc \
--disable-demuxer=vpk \
--disable-demuxer=vplayer \
--disable-demuxer=vqf \
--disable-demuxer=w64 \
--enable-demuxer=wav \
--disable-demuxer=wc3 \
--enable-demuxer=webm_dash_manifest \
--disable-demuxer=webvtt \
--disable-demuxer=wsaud \
--disable-demuxer=wsd \
--disable-demuxer=wsvqa \
--disable-demuxer=wtv \
--disable-demuxer=wv \
--disable-demuxer=wve \
--disable-demuxer=xa \
--disable-demuxer=xbin \
--disable-demuxer=xmv \
--disable-demuxer=xvag \
--disable-demuxer=xwma \
--disable-demuxer=yop \
--disable-demuxer=yuv4mpegpipe
"

echo $CONFIG_FLAG --extra-cflags="$EXTRA_CFLAGS" --extra-ldflags="$EXTRA_LDFLAGS" --extra-libs="$EXTRA_LIBS"
./configure $CONFIG_FLAG --extra-cflags="$EXTRA_CFLAGS" --extra-ldflags="$EXTRA_LDFLAGS" --extra-libs="$EXTRA_LIBS"
}

build()
{
	CPU=$1
	echo "build $CPU"
	configure $CPU
	make -j32
	make install
	
	if [ "$CPU" = "armv7a" ]
	then
		mkdir -p $(pwd)/prebuild/lib
		cp $(pwd)/android/$CPU/lib/*.so* $(pwd)/prebuild/lib
	else
		mkdir -p $(pwd)/prebuild/lib64
		cp $(pwd)/android/$CPU/lib/*.so* $(pwd)/prebuild/lib64
	fi
	make clean
}

make clean

build armv7a
build aarch64
