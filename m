Received: from eggs.gnu.org ([2001:4830:134:3::10]:48882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAdZG-00078Z-Cg
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAdZC-0004zq-Fu
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:35:18 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:36032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dAdZC-0004zh-8n
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:35:14 -0400
Received: by mail-lf0-x243.google.com with SMTP id h4so3509871lfj.3
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 07:35:14 -0700 (PDT)
Date: Tue, 16 May 2017 15:35:10 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170516143510.GE27093@stefanha-x1.localdomain>
References: <20170513022143.2838-1-n54@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6Vw0j8UKbyX0bfpA"
Content-Disposition: inline
In-Reply-To: <20170513022143.2838-1-n54@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] maintainers: Add myself as a NetBSD
 reviewer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


--6Vw0j8UKbyX0bfpA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 13, 2017 at 04:21:43AM +0200, Kamil Rytarowski wrote:
> I volunteer to review NetBSD patches.
> Adding myself will help to not miss some of them.
>=20
> Restore NetBSD as a maintained host.
>=20
> All patches to make qemu/pkgsrc building have been emitted to review.
>=20
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> ---
>  MAINTAINERS | 6 ++++++
>  configure   | 1 +
>  2 files changed, 7 insertions(+)

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--6Vw0j8UKbyX0bfpA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZGw4eAAoJEJykq7OBq3PIoXQH/jlGyqYaTDNA9KAuSokoshok
hBNCNxT32fGn1lHxp1p4/AUcmjpCpX+z/I1wVxE2XG3CeAJxDgCxwEa81u9RQETJ
wt031NnWO4fX/cmMFJNrvkn3p/mCZqVeaAFAUhtSPeNrGK0A8dYi2QsmuNuETuS6
/ggW79ulZONk0rQeu0pQXDk1ChqffSiA2SSRhe76QYvIT25YCB8on6oVVpf2bTJr
PDtNp5SpDnJ9u8Jdl0nD4dbtduFWTwzrhcQF8GiRZr7UhHo6NwwSM3XAsu0KysLv
KXUFpxv6gkCFUpJ4FsVnrF0q5AIK0knZ+X1LpIzeeUefC2jRpG6yxwcCFSmQFP0=
=ioAz
-----END PGP SIGNATURE-----

--6Vw0j8UKbyX0bfpA--
