Received: from eggs.gnu.org ([2001:4830:134:3::10]:36552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d7lSV-0000ig-I7
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:24:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d7lSS-00089S-FV
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:24:27 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d7lSS-00089I-Ad
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:24:24 -0400
Received: by mail-qt0-x241.google.com with SMTP id j13so10226454qta.3
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 09:24:24 -0700 (PDT)
Date: Mon, 8 May 2017 12:24:21 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170508162421.GC22428@stefanha-x1.localdomain>
References: <20170503113304.8704.13997.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Content-Disposition: inline
In-Reply-To: <20170503113304.8704.13997.stgit@PASHA-ISP>
Subject: Re: [Qemu-devel] [PATCH v2] maintainers: add maintainer for replay*
 files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 03, 2017 at 02:33:04PM +0300, Pavel Dovgalyuk wrote:
> Updating MAINTAINERS to set Pavel Dovgalyuk as record/replay maintainer
> and Paolo Bonzini as a reviewer.
>=20
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> ---
>  MAINTAINERS |   12 ++++++++++++
>  1 file changed, 12 insertions(+)

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZEJu1AAoJEJykq7OBq3PISfgH/jkuk1/SlFyEc+DbPfg6fTBg
x+xJ6MuY3K4z5dgyZJTE1Q0F/wDThFGzIaHbk6ZwjthfEeDekMZzSHRibRKpW+4r
h0gm2rlNyEjVkPDDlbHvfL2HJQDWJHqOb/FGiV4nxenoBZ1xsIqzFiURXsgykZyZ
mmjT+LTkDa/56AVO3GzC/mhiv5/iIwO9cHnsZ5AqY4rme9RUjdBguT/9GuHD0QFp
ij6EqfTQLxmbN65rh7d3W/kbAKsLbgzDTven/nHdQsV8Ae/N/K+FoPNJo6LL6YD8
OqCEB554e9gvmiSBgBoNCugaLQ05GOJIGYtn5x1rDGCd+yALEjfp+DZ6lkGfErg=
=Hrx2
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
