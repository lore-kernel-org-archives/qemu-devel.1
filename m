Received: from eggs.gnu.org ([2001:4830:134:3::10]:36439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1fz3ex-0005mo-8L
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 13:38:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1fz3c3-0005X7-63
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 13:35:11 -0400
References: <20180909153238.4046-1-programmingkidx@gmail.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <817e08da-e255-7d1f-4668-503bd3c009d1@weilnetz.de>
Date: Sun, 9 Sep 2018 19:34:53 +0200
MIME-Version: 1.0
In-Reply-To: <20180909153238.4046-1-programmingkidx@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RBSP6MN6HR3sTrNGNoKL1uzVxiY1FOcmO"
Subject: Re: [Qemu-devel] [PATCH] qemu-common.h: update copyright date to
 2018
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>, peter.maydell@linaro.org, qemu-devel@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RBSP6MN6HR3sTrNGNoKL1uzVxiY1FOcmO
From: Stefan Weil <sw@weilnetz.de>
To: John Arbuckle <programmingkidx@gmail.com>, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>
Message-ID: <817e08da-e255-7d1f-4668-503bd3c009d1@weilnetz.de>
Subject: Re: [Qemu-devel] [PATCH] qemu-common.h: update copyright date to 2018
References: <20180909153238.4046-1-programmingkidx@gmail.com>
In-Reply-To: <20180909153238.4046-1-programmingkidx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am 09.09.2018 um 17:32 schrieb John Arbuckle:
> Currently the copyright date is set to 2017. Update the date to say
> 2018.
>=20
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
>  include/qemu-common.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/qemu-common.h b/include/qemu-common.h
> index 85f4749aef..ed60ba251d 100644
> --- a/include/qemu-common.h
> +++ b/include/qemu-common.h
> @@ -17,7 +17,7 @@
>  #define TFR(expr) do { if ((expr) !=3D -1) break; } while (errno =3D=3D=
 EINTR)
> =20
>  /* Copyright string for -version arguments, About dialogs, etc */
> -#define QEMU_COPYRIGHT "Copyright (c) 2003-2017 " \
> +#define QEMU_COPYRIGHT "Copyright (c) 2003-2018 " \
>      "Fabrice Bellard and the QEMU Project developers"
> =20
>  /* Bug reporting information for --help arguments, About dialogs, etc =
*/
>=20


Reviewed-by: Stefan Weil <sw@weilnetz.de>

I think this is trivial enough for qemu-trivial.

Thanks,
Stefan


--RBSP6MN6HR3sTrNGNoKL1uzVxiY1FOcmO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESSNv6nXJXWmOwreK4Iwh1Wd0UK0FAluVWcQACgkQ4Iwh1Wd0
UK2DWA//VoOtjl67SvR9P6daDYJ9g2Ay4JU3AxsA76wNOHVsJZJoAVxNlD7Zipsl
ESbCeltWN9cBfieJECY+HLgnKj/WANf6TBnqriWoKtBYH5zaaOheVMhEZAMx1l52
gtiLuGt1dWmpFeN8WV/GlrVGtKsNc9XFYX4+ZKF3FDdV8uyzHaCrKTwkxRY9VH6T
jE5pWmZWAb/7TT00F6xOLQ2QBG7HoxMH+TP0wntSwbAuTUKzkx9xI8DNULt1IFy7
vfO1Jd8Tp5B8W4J18ZZMkjQ2p/L8/t1ntKp3HEGCFLXihYpq8y18L5S06Q3X37ea
LUBCZFZ8lyNHGj2HKp273hgDaSgrYB5a/dD7PO+mjY9BCKbX/p8S8UD6IbkkNuoJ
kw2Gw0YHnbwwVylevCfQeIm6gv2nbGwfWOfWySFBMm12Mv1o1TWBszsB2nYNxUBw
ApZ5ibgJjFyY0/BXbMjxjTtmeC99cGlI3PT1QWqDf5l5BLcah0ep7CoCi/eiDDUS
d941M7RddBOFGNdAhf8oARsLHCt6GIU6OnS37eQADTsJfW8/i+Ou4BJXvE3ROsGt
RNclPOXeQNm5Fxgd5du3cH7GXrKP55TIyddVzuz8ZUnBH30oTWxDNkGQ21Pw7CS/
EU5/BYRSHVOp77+eF49+K2Uon+J+wjuwh5AhK808DIBeS69G1S4=
=EwQX
-----END PGP SIGNATURE-----

--RBSP6MN6HR3sTrNGNoKL1uzVxiY1FOcmO--
