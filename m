Received: from eggs.gnu.org ([2001:4830:134:3::10]:54003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1db1yw-0000Wf-Dt
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1db1yt-0007qI-Qb
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:54:54 -0400
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-26-f4bug@amsat.org>
From: Yongbok Kim <yongbok.kim@imgtec.com>
Message-ID: <635b7f27-cf61-61b8-b363-255578c54547@imgtec.com>
Date: Fri, 28 Jul 2017 10:54:40 +0100
MIME-Version: 1.0
In-Reply-To: <20170728053610.15770-26-f4bug@amsat.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 25/47] MAINTAINERS: add missing MIPS entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org



On 28/07/2017 06:35, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fa6b0d189a..7354afb9f4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -182,6 +182,7 @@ F: include/hw/intc/mips_gic.h
>  F: include/hw/timer/mips_gictimer.h
>  F: tests/tcg/mips/
>  F: disas/mips.c
> +F: default-configs/mips*-softmmu.mak
> =20
>  Moxie
>  M: Anthony Green <green@moxielogic.com>
>=20

Acked-by: Yongbok Kim <yongbok.kim@imgtec.com>

Regards,
Yongbok
