Received: from eggs.gnu.org ([2001:4830:134:3::10]:34189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gPUsA-00033b-JC
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:57:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gPUs7-0002kw-9c
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:57:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gPUs6-0002hC-UJ
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:56:59 -0500
References: <20181121153036.2941-1-famz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <9f2d3627-cbe9-3c51-4650-1b7e1e278999@redhat.com>
Date: Wed, 21 Nov 2018 10:56:56 -0500
MIME-Version: 1.0
In-Reply-To: <20181121153036.2941-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: fam@euphon.net, pbonzini@redhat.com, stefanha@redhat.com, alex.bennee@linaro.org



On 11/21/18 10:30 AM, Fam Zheng wrote:
> Since I am about to change company, update the email address in
> MAINTAINERS to my personal one. Depending on responsibility changes I
> may eventually fade out in some of the maintained areas, but that will
> be figured out afterward, or maybe I'll use the work email later. For
> now, just do a search and replace.
>=20
> Signed-off-by: Fam Zheng <fam@euphon.net>
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

Best of luck!

> ---
>  MAINTAINERS | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1032406c56..906d40d06d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1252,7 +1252,7 @@ T: git https://github.com/jasowang/qemu.git net
> =20
>  SCSI
>  M: Paolo Bonzini <pbonzini@redhat.com>
> -R: Fam Zheng <famz@redhat.com>
> +R: Fam Zheng <fam@euphon.net>
>  S: Supported
>  F: include/hw/scsi/*
>  F: hw/scsi/*
> @@ -1565,7 +1565,7 @@ T: git https://repo.or.cz/qemu/kevin.git block
> =20
>  Block I/O path
>  M: Stefan Hajnoczi <stefanha@redhat.com>
> -M: Fam Zheng <famz@redhat.com>
> +M: Fam Zheng <fam@euphon.net>
>  L: qemu-block@nongnu.org
>  S: Supported
>  F: util/async.c
> @@ -1579,7 +1579,7 @@ T: git https://github.com/stefanha/qemu.git block
> =20
>  Block SCSI subsystem
>  M: Paolo Bonzini <pbonzini@redhat.com>
> -R: Fam Zheng <famz@redhat.com>
> +R: Fam Zheng <fam@euphon.net>
>  L: qemu-block@nongnu.org
>  S: Supported
>  F: include/scsi/*
> @@ -1611,7 +1611,7 @@ F: qapi/transaction.json
>  T: git https://repo.or.cz/qemu/armbru.git block-next
> =20
>  Dirty Bitmaps
> -M: Fam Zheng <famz@redhat.com>
> +M: Fam Zheng <fam@euphon.net>
>  M: John Snow <jsnow@redhat.com>
>  L: qemu-block@nongnu.org
>  S: Supported
> @@ -1985,7 +1985,7 @@ F: tests/test-throttle.c
>  L: qemu-block@nongnu.org
> =20
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
> =20
>  Null Block Driver
> -M: Fam Zheng <famz@redhat.com>
> +M: Fam Zheng <fam@euphon.net>
>  L: qemu-block@nongnu.org
>  S: Supported
>  F: block/null.c
> =20
>  NVMe Block Driver
> -M: Fam Zheng <famz@redhat.com>
> +M: Fam Zheng <fam@euphon.net>
>  L: qemu-block@nongnu.org
>  S: Supported
>  F: block/nvme*
> @@ -2339,7 +2339,7 @@ Build and test automation
>  -------------------------
>  Build and test automation
>  M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> -M: Fam Zheng <famz@redhat.com>
> +M: Fam Zheng <fam@euphon.net>
>  R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>  L: qemu-devel@nongnu.org
>  S: Maintained
>=20
