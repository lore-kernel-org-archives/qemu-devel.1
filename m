Received: from eggs.gnu.org ([2001:4830:134:3::10]:43406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gO5SN-0007f4-N1
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 13:36:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gO5SJ-0000tx-PM
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 13:36:35 -0500
Received: from mail-yw1-f49.google.com ([209.85.161.49]:46674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gO5SJ-0000tp-L9
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 13:36:31 -0500
Received: by mail-yw1-f49.google.com with SMTP id t13so7247280ywe.13
	for <qemu-devel@nongnu.org>; Sat, 17 Nov 2018 10:36:31 -0800 (PST)
MIME-Version: 1.0
References: <1542470080-5797-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1542470080-5797-12-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1542470080-5797-12-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 17 Nov 2018 19:36:21 +0100
Message-ID: <CAAdtpL7DtkyO34yFqrumB4PyZSMCEzMB+JpFHrb_6Htw5dcqsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 11/11] MAINTAINERS: Add Stefan Markovic as a
 MIPS reviewer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <Aleksandar.Markovic@rt-rk.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, amarkovic@wavecomp.com

Le sam. 17 nov. 2018 16:56, Aleksandar Markovic <
aleksandar.markovic@rt-rk.com> a =C3=A9crit :

> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Add Stefan Markovic as a MIPS reviewer. He had several key
> contributions to QEMU for MIPS this year. He is a meticulous
> person with the ability to think and act on many levels.
>
> Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4b8db61..f718264 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -190,6 +190,7 @@ F: disas/microblaze.c
>  MIPS
>  M: Aurelien Jarno <aurelien@aurel32.net>
>  M: Aleksandar Markovic <amarkovic@wavecomp.com>
> +R: Stefan Markovic <smarkovic@wavecomp.com>
>  S: Maintained
>  F: target/mips/
>  F: hw/mips/
> @@ -336,6 +337,7 @@ F: target/arm/kvm.c
>
>  MIPS
>  M: James Hogan <jhogan@kernel.org>
> +R: Stefan Markovic <smarkovic@wavecomp.com>
>  S: Maintained
>  F: target/mips/kvm.c
>
> @@ -741,27 +743,32 @@ MIPS Machines
>  -------------
>  Jazz
>  M: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> +R: Stefan Markovic <smarkovic@wavecomp.com>
>

I find a bit unfair, while you don't allow to list reviewers not from the
MIPS company to your section, you add reviewers to section where you are
not listed as maintainer.
Why not add yourself as maintainer in these sections?

I understand your concept of "reviewer" as someone whom R-b tag weight more
than unlisted person. Is it how you see it for the MIPS subsystem?

Thanks,

Phil.

 S: Maintained
>  F: hw/mips/mips_jazz.c
>
>  Malta
>  M: Aurelien Jarno <aurelien@aurel32.net>
> +R: Stefan Markovic <smarkovic@wavecomp.com>
>  S: Maintained
>  F: hw/mips/mips_malta.c
>
>  Mipssim
>  M: Aleksandar Markovic <amarkovic@wavecomp.com>
> +R: Stefan Markovic <smarkovic@wavecomp.com>
>  S: Odd Fixes
>  F: hw/mips/mips_mipssim.c
>  F: hw/net/mipsnet.c
>
>  R4000
>  M: Aurelien Jarno <aurelien@aurel32.net>
> +R: Stefan Markovic <smarkovic@wavecomp.com>
>  S: Maintained
>  F: hw/mips/mips_r4k.c
>
>  Fulong 2E
>  M: Aleksandar Markovic <amarkovic@wavecomp.com>
> +R: Stefan Markovic <smarkovic@wavecomp.com>
>  S: Odd Fixes
>  F: hw/mips/mips_fulong2e.c
>  F: hw/isa/vt82c686.c
> @@ -770,6 +777,7 @@ F: include/hw/isa/vt82c686.h
>
>  Boston
>  M: Paul Burton <pburton@wavecomp.com>
> +R: Stefan Markovic <smarkovic@wavecomp.com>
>  S: Maintained
>  F: hw/core/loader-fit.c
>  F: hw/mips/boston.c
> @@ -1992,6 +2000,7 @@ F: disas/i386.c
>
>  MIPS target
>  M: Aurelien Jarno <aurelien@aurel32.net>
> +R: Stefan Markovic <smarkovic@wavecomp.com>
>  S: Maintained
>  F: tcg/mips/
>  F: disas/mips.c
> --
> 2.7.4
>
>
>
