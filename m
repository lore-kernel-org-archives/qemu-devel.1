Received: from eggs.gnu.org ([208.118.235.92]:55635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1gcVCE-0001Rw-DC
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 07:55:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1gcVC9-0000cc-Ru
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 07:55:30 -0500
Received: from mail-eopbgr750130.outbound.protection.outlook.com
	([40.107.75.130]:2368
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
	id 1gcVC3-0000Js-UY
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 07:55:23 -0500
From: Aleksandar Rikalo <arikalo@wavecomp.com>
Date: Thu, 27 Dec 2018 12:55:11 +0000
Message-ID: <DM5PR22MB1658AE32D35D1CCCFACEC277D2B60@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1545844514-1854-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1545844514-1854-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1545844514-1854-5-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/4] MAINTAINERS: Add Aleksandar Rikalo
 as a reviewer for MIPS content
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Paul Burton <pburton@wavecomp.com>, "hpoussin@reactos.org" <hpoussin@reactos.org>, "jhogan@kernel.org" <jhogan@kernel.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Wednesday, December 26, 2018 6:15 PM
> To: qemu-devel@nongnu.org
> Cc: aurelien@aurel32.net; Paul Burton; hpoussin@reactos.org; jhogan@kerne=
l.org; Aleksandar Markovic; Stefan Markovic; > Aleksandar Rikalo
> Subject: [PATCH v3 4/4] MAINTAINERS: Add Aleksandar Rikalo as a reviewer =
for MIPS content
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Add Aleksandar Rikalo as a reviewer for MIPS content. Aleksandar
> brings to us more than six years of experience in working on a variety
> of development tools for MIPS architectures, and will greatly help
> QEMU community understand and support intricacies of MIPS better.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)

Acked-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>

>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 39fb1ae..b06f534 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -205,6 +205,7 @@ F: disas/microblaze.c
>  MIPS
>  M: Aurelien Jarno <aurelien@aurel32.net>
>  M: Aleksandar Markovic <amarkovic@wavecomp.com>
> +R: Aleksandar Rikalo <arikalo@wavecomp.com>
>  R: Stefan Markovic <smarkovic@wavecomp.com>
>  S: Maintained
>  F: target/mips/
> @@ -362,6 +363,7 @@ F: target/arm/kvm.c
>
>  MIPS
>  M: James Hogan <jhogan@kernel.org>
> +R: Aleksandar Rikalo <arikalo@wavecomp.com>
>  R: Stefan Markovic <smarkovic@wavecomp.com>
>  S: Maintained
>  F: target/mips/kvm.c
> @@ -871,6 +873,7 @@ MIPS Machines
>  -------------
>  Jazz
>  M: Herv=E9 Poussineau <hpoussin@reactos.org>
> +R: Aleksandar Rikalo <arikalo@wavecomp.com>
>  R: Stefan Markovic <smarkovic@wavecomp.com>
>  S: Maintained
>  F: hw/mips/mips_jazz.c
> @@ -879,12 +882,14 @@ F: hw/dma/rc4030.c
>
>  Malta
>  M: Aurelien Jarno <aurelien@aurel32.net>
> +R: Aleksandar Rikalo <arikalo@wavecomp.com>
>  R: Stefan Markovic <smarkovic@wavecomp.com>
>  S: Maintained
>  F: hw/mips/mips_malta.c
>
>  Mipssim
>  M: Aleksandar Markovic <amarkovic@wavecomp.com>
> +R: Aleksandar Rikalo <arikalo@wavecomp.com>
>  R: Stefan Markovic <smarkovic@wavecomp.com>
>  S: Odd Fixes
>  F: hw/mips/mips_mipssim.c
> @@ -892,12 +897,14 @@ F: hw/net/mipsnet.c
>
>  R4000
>  M: Aurelien Jarno <aurelien@aurel32.net>
> +R: Aleksandar Rikalo <arikalo@wavecomp.com>
>  R: Stefan Markovic <smarkovic@wavecomp.com>
>  S: Maintained
>  F: hw/mips/mips_r4k.c
>
>  Fulong 2E
>  M: Aleksandar Markovic <amarkovic@wavecomp.com>
> +R: Aleksandar Rikalo <arikalo@wavecomp.com>
>  R: Stefan Markovic <smarkovic@wavecomp.com>
>  S: Odd Fixes
>  F: hw/mips/mips_fulong2e.c
> @@ -907,6 +914,7 @@ F: include/hw/isa/vt82c686.h
>
>  Boston
>  M: Paul Burton <pburton@wavecomp.com>
> +R: Aleksandar Rikalo <arikalo@wavecomp.com>
>  R: Stefan Markovic <smarkovic@wavecomp.com>
>  S: Maintained
>  F: hw/core/loader-fit.c
> @@ -2163,6 +2171,7 @@ F: disas/i386.c
>
>  MIPS target
>  M: Aurelien Jarno <aurelien@aurel32.net>
> +R: Aleksandar Rikalo <arikalo@wavecomp.com>
>  R: Stefan Markovic <smarkovic@wavecomp.com>
>  S: Maintained
>  F: tcg/mips/
> --
> 2.7.4
>
