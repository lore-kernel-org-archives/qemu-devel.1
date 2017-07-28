Received: from eggs.gnu.org ([2001:4830:134:3::10]:47474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1db3IS-00062f-Tv
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 07:19:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1db3IM-000740-VU
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 07:19:08 -0400
Date: Fri, 28 Jul 2017 13:18:53 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170728111853.llmfq5ayjp2j36sh@aurel32.net>
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-30-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20170728053610.15770-30-f4bug@amsat.org>
Sender: Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: [Qemu-devel] [PATCH 29/47] MAINTAINERS: add missing SH-4 entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-15?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 2017-07-28 02:35, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9a0da13bcd..bb1cb1fc1c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -235,6 +235,7 @@ F: target/sh4/
>  F: hw/sh4/
>  F: disas/sh4.c
>  F: include/hw/sh4/
> +F: default-configs/sh4*-softmmu.mak
> =20
>  SPARC
>  M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Acked-by: Aurelien Jarno <aurelien@aurel32.net>

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
