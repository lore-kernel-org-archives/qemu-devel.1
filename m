Received: from eggs.gnu.org ([2001:4830:134:3::10]:59219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eX2db-00047Y-5C
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 05:20:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eX2da-0006vl-Bd
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 05:20:39 -0500
Date: Thu, 4 Jan 2018 10:20:28 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180104102028.GB10106@stefanha-x1.localdomain>
References: <20171226025247.11082-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <20171226025247.11082-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 0/2] qemu-img: Document --force-share /
 -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kchamart@redhat.com, Kevin Wolf <kwolf@redhat.com>, eblake@redhat.com, Max Reitz <mreitz@redhat.com>


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2017 at 10:52:45AM +0800, Fam Zheng wrote:
> v5: Clean up the @table @var section first. [Kevin, Peter]
>=20
> Fam Zheng (2):
>   qemu-img.texi: Clean up parameter list
>   qemu-img: Document --force-share / -U
>=20
>  qemu-img.texi | 75 ++++++++++++++++++++++++++++++++++++++---------------=
------
>  1 file changed, 48 insertions(+), 27 deletions(-)
>=20
> --=20
> 2.14.3
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaTf/sAAoJEJykq7OBq3PICiAH/2zr9gWQJd3ikq4zilQlA3N9
KRuP/VSdhuY21YmTO843crToqzxsSN2j4C7sJnkc8fezQr7hs3XWsUpJmmF7zXZO
PjY+h52SmdkiIdk2GKxv53MZd5wR0kojmyXW7rBclTIFjZ4Jz3j2uick9+WDZKzP
gMqt1lRvEiyTCBmYwHBsCexGCM7222tEXtxl/ggmmOgxO2DjVXQbOmTIFmPw2rPt
aGC3zN1tpsPJIOUiAOR+BZt6Ni8gvahmXgI2EtUNX6dRXxyFvHfQ9KWE9Zql9Hvv
q/I79R9J2KKW3Wwpk/toY6SHBk0/mxb8LrL7+RD3+S9F8oe6lG89nIgKh8cQkb8=
=4iGa
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
