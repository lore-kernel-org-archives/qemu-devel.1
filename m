Received: from eggs.gnu.org ([209.51.188.92]:50338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1ghVgT-00032T-V5
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:27:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1ghVgH-0002Lt-M5
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:27:15 -0500
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142]:33848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1ghVgF-0002EH-Ne
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:27:11 -0500
Received: by mail-it1-x142.google.com with SMTP id x124so14834886itd.1
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 00:27:11 -0800 (PST)
MIME-Version: 1.0
References: <1545028456-2797-1-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1545028456-2797-1-git-send-email-liq3ea@gmail.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 10 Jan 2019 16:26:33 +0800
Message-ID: <CAKXe6SL74QC+Gsxo2TiPStFgG-mnwhFUTWyMJtCQKb8mqjSAyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] main-loop: remove unused header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>

Ping...

Thanks,
Li Qiang

Li Qiang <liq3ea@gmail.com> =E4=BA=8E2018=E5=B9=B412=E6=9C=8817=E6=97=A5=E5=
=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=882:34=E5=86=99=E9=81=93=EF=BC=9A

> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  util/main-loop.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/util/main-loop.c b/util/main-loop.c
> index affe0403c5..845a4b1f13 100644
> --- a/util/main-loop.c
> +++ b/util/main-loop.c
> @@ -26,7 +26,6 @@
>  #include "qapi/error.h"
>  #include "qemu/cutils.h"
>  #include "qemu/timer.h"
> -#include "qemu/sockets.h"      // struct in_addr needed for libslirp.h
>  #include "sysemu/qtest.h"
>  #include "sysemu/cpus.h"
>  #include "sysemu/replay.h"
> --
> 2.11.0
>
>
