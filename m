Received: from eggs.gnu.org ([209.51.188.92]:52768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gqXSx-0003RY-BB
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 01:10:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gqXSw-0007Hy-Fx
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 01:10:47 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gqXSw-0007Go-8k
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 01:10:46 -0500
Received: by mail-pl1-x643.google.com with SMTP id b5so6320767plr.4
	for <qemu-devel@nongnu.org>; Sun, 03 Feb 2019 22:10:45 -0800 (PST)
Date: Mon, 4 Feb 2019 14:10:40 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190204061040.GH29758@stefanha-x1.localdomain>
References: <20190203204950.8447-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YrlhzR9YrZtruaFS"
Content-Disposition: inline
In-Reply-To: <20190203204950.8447-1-cota@braap.org>
Subject: Re: [Qemu-devel] [PATCH] qemu-doc: remove outdated comment about
 full-system SMP support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, David Steiner <davids@bitmail.cc>


--YrlhzR9YrZtruaFS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 03, 2019 at 03:49:50PM -0500, Emilio G. Cota wrote:
> We have had SMP support in TCG for quite a while; remove
> the reference to a necessary in-kernel accelerator.
>=20
> Note that I was tempted to enumerate here the MTTCG-compatible
> ISAs, but I decided against it because (1) most popular target ISAs
> have been converted, and (2) I doubt we'd do a good job in keeping
> the list up to date.
>=20
> Reported-by: David Steiner <davids@bitmail.cc>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  qemu-doc.texi | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--YrlhzR9YrZtruaFS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcV9dgAAoJEJykq7OBq3PI/vEH/iHLHW2v4NC7JSC4GyWReRuI
PHM6nCMaSn6xNyRUIR+mzqGoILYPkDiGRZP1GppumLmv2HdLJSPHUg0PmPeGbhap
9BfliNJaWU8XosQ5xHAs0bj/EQFLl0ruDJ7DyXwsN8nwSNNoGCK4oHYWg01Byhoe
SKFmOgqi+XkHXDM4xDymxlw9XF/78zDgwW3GSYNGxzg7DZitr+2NcbgswduW++xn
ylrm3Mh5inCzbyD+N7aWUmNCw/KHs0Sj4DrqGDvCIZQbP3duCbELFpwPrgdgz9od
+L0j7gITYkZEHmzsIoijtNh/6ZJXPB3hniFCpcZfs2z8iPwOhvSMV5GA2X5v+JM=
=z76U
-----END PGP SIGNATURE-----

--YrlhzR9YrZtruaFS--
