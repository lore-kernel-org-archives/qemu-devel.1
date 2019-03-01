Received: from eggs.gnu.org ([209.51.188.92]:60221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gziXu-0004ZI-Vs
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 08:49:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gziXq-000415-P8
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 08:49:48 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:55992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gziXo-0003zb-0Y
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 08:49:44 -0500
Date: Fri, 1 Mar 2019 05:49:26 -0800
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190301134926.v34djgqxtclooevo@function>
References: <20190301100310.22345-1-alex.bennee@linaro.org>
	<20190301100310.22345-4-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190301100310.22345-4-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/5] contrib: gitdm: add more individual
 contributors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>, BALATON Zoltan <balaton@eik.bme.hu>

Alex Benn=C3=A9e, le ven. 01 mars 2019 10:03:08 +0000, a ecrit:
> I know Richard's is right because I asked him in the pub. I'm guessing
> Fredrik's based on the fact I vaguely remember an Atari demo. The
> others I attributed to academic institutions last time I posted so
> have moved them to individuals as requested.
>=20
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Fredrik Noring <noring@nocrew.org>
> Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Acked-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  contrib/gitdm/group-map-individuals | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-=
map-individuals
> index afdbe7d460..05e355d30e 100644
> --- a/contrib/gitdm/group-map-individuals
> +++ b/contrib/gitdm/group-map-individuals
> @@ -8,3 +8,8 @@
>  f4bug@amsat.org
>  mjt@tls.msk.ru
>  mark.cave-ayland@ilande.co.uk
> +rth@twiddle.net
> +noring@nocrew.org
> +samuel.thibault@ens-lyon.org
> +aurelien@aurel32.net
> +balaton@eik.bme.hu
> --=20
> 2.20.1
>=20

--=20
Samuel
	/* Amuse the user in a SPARC fashion */
	if (err) printk(
KERN_CRIT "      _______________________________ \n"
KERN_CRIT "     < Your System ate a SPARC! Gah! >\n"
KERN_CRIT "      ------------------------------- \n"
KERN_CRIT "             \\   ^__^\n"
KERN_CRIT "              \\  (xx)\\_______\n"
KERN_CRIT "                 (__)\\       )\\/\\\n"
KERN_CRIT "                  U  ||----w |\n"
KERN_CRIT "                     ||     ||\n");
(From linux/arch/parisc/kernel/traps.c:die_if_kernel())
