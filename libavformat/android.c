/*
 * ANDROID Protocol
 * Copyright (c) 2022 V
 * add by VinterYoung
 */

#include "libavutil/avstring.h"
#include "libavutil/internal.h"
#include "libavutil/opt.h"
#include "avformat.h"
#if HAVE_DIRENT_H
#include <dirent.h>
#endif
#include <fcntl.h>
#if HAVE_IO_H
#include <io.h>
#endif
#if HAVE_UNISTD_H
#include <unistd.h>
#endif
#include <sys/stat.h>
#include <stdlib.h>
#include "os_support.h"
#include "url.h"

typedef struct AndroidContext {
    const AVClass *class;
    int fd;
    int trunc;
    int blocksize;
    int follow;
    int seekable;
    DIR *dir;
} AndroidContext;

static const AVOption options[] = {
    { "truncate", "truncate existing files on write", offsetof(AndroidContext, trunc), AV_OPT_TYPE_BOOL, { .i64 = 1 }, 0, 1, AV_OPT_FLAG_ENCODING_PARAM },
    { "blocksize", "set I/O operation maximum block size", offsetof(AndroidContext, blocksize), AV_OPT_TYPE_INT, { .i64 = INT_MAX }, 1, INT_MAX, AV_OPT_FLAG_ENCODING_PARAM },
    { "follow", "Follow a file as it is being written", offsetof(AndroidContext, follow), AV_OPT_TYPE_INT, { .i64 = 0 }, 0, 1, AV_OPT_FLAG_DECODING_PARAM },
    { "seekable", "Sets if the file is seekable", offsetof(AndroidContext, seekable), AV_OPT_TYPE_INT, { .i64 = -1 }, -1, 0, AV_OPT_FLAG_DECODING_PARAM | AV_OPT_FLAG_ENCODING_PARAM },
    { NULL }
};

static const AVClass android_context_class = {
    .class_name = "android",
    .item_name  = av_default_item_name,
    .option     = options,
    .version    = LIBAVUTIL_VERSION_INT,
};

static int android_open(URLContext *h, const char *url, int flags)
{
    av_log(NULL, AV_LOG_ERROR, "yangwenandroid %s %d\n",__FUNCTION__,__LINE__);
    return 0;
}
static int android_read(URLContext *h, unsigned char *buf, int size)
{
    return 0;
}

static int android_write(URLContext *h, const unsigned char *buf, int size)
{
    return -1;
}

static int64_t android_seek(URLContext *h, int64_t pos, int whence)
{
    return 0;
}

static int android_close(URLContext *h)
{
    return 0;
}

static int android_get_handle(URLContext *h)
{
    return (intptr_t)h->priv_data;
}

static int android_check(URLContext *h, int mask)
{
    return (mask & AVIO_FLAG_READ);
}

const URLProtocol ff_android_protocol = {
    .name                = "android",
    .url_open            = android_open,
    .url_read            = android_read,
    .url_seek            = android_seek,
    .url_close           = android_close,
	.url_get_file_handle = android_get_handle,
	.url_check           = android_check,
    .priv_data_size      = sizeof(AndroidContext),
    .priv_data_class     = &android_context_class,
};

