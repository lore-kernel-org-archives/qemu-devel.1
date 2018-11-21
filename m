Received: from eggs.gnu.org ([2001:4830:134:3::10]:33617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gPUq8-0002AV-5E
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:54:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gPUpz-0007Eh-7J
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:54:49 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53155)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gPUpv-00074y-He
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:54:43 -0500
Received: by mail-wm1-x344.google.com with SMTP id r11-v6so5998726wmb.2
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 07:54:43 -0800 (PST)
MIME-Version: 1.0
References: <20181121153036.2941-1-famz@redhat.com>
In-Reply-To: <20181121153036.2941-1-famz@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 21 Nov 2018 19:54:29 +0400
Message-ID: <CAJ+F1CK1JGarsRRevfL-3uR3nDJbGsAUtQeW0cQ0JoVK27GRWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Fam Zheng <famz@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, fam@euphon.net, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

Hi

On Wed, Nov 21, 2018 at 7:39 PM Fam Zheng <famz@redhat.com> wrote:
>
> Since I am about to change company, update the email address in
> MAINTAINERS to my personal one. Depending on responsibility changes I
> may eventually fade out in some of the maintained areas, but that will
> be figured out afterward, or maybe I'll use the work email later. For
> now, just do a search and replace.
>
> Signed-off-by: Fam Zheng <fam@euphon.net>
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Meanwhile, we can make guesses on your future work address! :)

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
>  M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> -M: Fam Zheng <famz@redhat.com>
> +M: Fam Zheng <fam@euphon.net>
>  R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>  L: qemu-devel@nongnu.org
>  S: Maintained
> --
> 2.17.2
>
>


--=20
Marc-Andr=C3=A9 Lureau
