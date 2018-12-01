Received: from eggs.gnu.org ([2001:4830:134:3::10]:42045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gTEWW-00009a-Ac
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 18:18:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gTEWS-0000lh-Ie
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 18:18:08 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36703)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gTEWS-0000lQ-Cm
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 18:18:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id u3so8616749wrs.3
	for <qemu-devel@nongnu.org>; Sat, 01 Dec 2018 15:18:04 -0800 (PST)
References: <20181121153036.2941-1-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bdb6e6b7-0da0-d2aa-893f-a14e16230e4d@redhat.com>
Date: Sun, 2 Dec 2018 00:17:58 +0100
MIME-Version: 1.0
In-Reply-To: <20181121153036.2941-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Update email address for Fam
 Zheng
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: fam@euphon.net, QEMU Trivial <qemu-trivial@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, jsnow@redhat.com, stefanha@redhat.com, alex.bennee@linaro.org

Cc'ing Trivial@ & Peter.

I seems this email is now over, thus it would be nice to have this patch
merged in 4.1 early opening.
(Does it apply as a fix before the 4.0 release?)

On 21/11/18 16:30, Fam Zheng wrote:
> Since I am about to change company, update the email address in
> MAINTAINERS to my personal one. Depending on responsibility changes I
> may eventually fade out in some of the maintained areas, but that will
> be figured out afterward, or maybe I'll use the work email later. For
> now, just do a search and replace.
> 
> Signed-off-by: Fam Zheng <fam@euphon.net>
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  MAINTAINERS | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1032406c56..906d40d06d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1252,7 +1252,7 @@ T: git https://github.com/jasowang/qemu.git net
>  
>  SCSI
>  M: Paolo Bonzini <pbonzini@redhat.com>
> -R: Fam Zheng <famz@redhat.com>
> +R: Fam Zheng <fam@euphon.net>
>  S: Supported
>  F: include/hw/scsi/*
>  F: hw/scsi/*
> @@ -1565,7 +1565,7 @@ T: git https://repo.or.cz/qemu/kevin.git block
>  
>  Block I/O path
>  M: Stefan Hajnoczi <stefanha@redhat.com>
> -M: Fam Zheng <famz@redhat.com>
> +M: Fam Zheng <fam@euphon.net>
>  L: qemu-block@nongnu.org
>  S: Supported
>  F: util/async.c
> @@ -1579,7 +1579,7 @@ T: git https://github.com/stefanha/qemu.git block
>  
>  Block SCSI subsystem
>  M: Paolo Bonzini <pbonzini@redhat.com>
> -R: Fam Zheng <famz@redhat.com>
> +R: Fam Zheng <fam@euphon.net>
>  L: qemu-block@nongnu.org
>  S: Supported
>  F: include/scsi/*
> @@ -1611,7 +1611,7 @@ F: qapi/transaction.json
>  T: git https://repo.or.cz/qemu/armbru.git block-next
>  
>  Dirty Bitmaps
> -M: Fam Zheng <famz@redhat.com>
> +M: Fam Zheng <fam@euphon.net>
>  M: John Snow <jsnow@redhat.com>
>  L: qemu-block@nongnu.org
>  S: Supported
> @@ -1985,7 +1985,7 @@ F: tests/test-throttle.c
>  L: qemu-block@nongnu.org
>  
>  UUID
> -M: Fam Zheng <famz@redhat.com>
> +M: Fam Zheng <fam@euphon.net>
>  S: Supported
>  F: util/uuid.c
>  F: include/qemu/uuid.h
> @@ -2116,7 +2116,7 @@ F: disas/tci.c
>  Block drivers
>  -------------
>  VMDK
> -M: Fam Zheng <famz@redhat.com>
> +M: Fam Zheng <fam@euphon.net>
>  L: qemu-block@nongnu.org
>  S: Supported
>  F: block/vmdk.c
> @@ -2202,13 +2202,13 @@ F: block/gluster.c
>  T: git https://github.com/codyprime/qemu-kvm-jtc.git block
>  
>  Null Block Driver
> -M: Fam Zheng <famz@redhat.com>
> +M: Fam Zheng <fam@euphon.net>
>  L: qemu-block@nongnu.org
>  S: Supported
>  F: block/null.c
>  
>  NVMe Block Driver
> -M: Fam Zheng <famz@redhat.com>
> +M: Fam Zheng <fam@euphon.net>
>  L: qemu-block@nongnu.org
>  S: Supported
>  F: block/nvme*
> @@ -2339,7 +2339,7 @@ Build and test automation
>  -------------------------
>  Build and test automation
>  M: Alex Bennée <alex.bennee@linaro.org>
> -M: Fam Zheng <famz@redhat.com>
> +M: Fam Zheng <fam@euphon.net>
>  R: Philippe Mathieu-Daudé <f4bug@amsat.org>
>  L: qemu-devel@nongnu.org
>  S: Maintained
> 
