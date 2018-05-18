Received: from eggs.gnu.org ([2001:4830:134:3::10]:43271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fJe5t-0007Ga-Ah
	for qemu-devel@nongnu.org; Fri, 18 May 2018 08:02:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fJe5q-000514-PR
	for qemu-devel@nongnu.org; Fri, 18 May 2018 08:02:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38762 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fJe5q-000505-K2
	for qemu-devel@nongnu.org; Fri, 18 May 2018 08:02:42 -0400
Date: Fri, 18 May 2018 13:02:39 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180518120239.GA31915@stefanha-x1.localdomain>
References: <20180518091440.1559-1-alex.bennee@linaro.org>
	<20180518091440.1559-3-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <20180518091440.1559-3-alex.bennee@linaro.org>
Subject: Re: [Qemu-devel] [RFC PATCH 2/2] tests/Makefile: comment out flakey
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: famz@redhat.com, pbonzini@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 18, 2018 at 10:14:40AM +0100, Alex Benn=E9e wrote:
> The following tests keep showing up in failed Travis runs:
>=20
>   - test-aio

What is the issue?

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa/sDfAAoJEJykq7OBq3PIawoH/jnySYYGr07gwjaaqDE+KVsl
5HB383WXAx5UtHvemzJ8oSiLSJlPuCqapEfSMK1/snQjDZ0uat1Ilbmhh3WqXQFb
wArSFa+aGzaSuHswpJxbJqIzsoQk0roUlP2Q61qbxgBu9utduhjrtmMG7NA45aui
dNb38jz0Gk7ZTvRYXj+790rcdsWdoOPtF6/CoHd7GgPoNMuHZ1bDk9vqzARS8d2x
5wquMZPNOGDkxDestmeSPKUfmVmuAipIHtoSIydVa17JGvwucl7q4yhi+m7Fe7GZ
Kb9ED0lXG9+bIh1KdYYU5YaIiedLvkWl4YtrJHCNO/BnfUlZoCQWROCbHaEwWFg=
=rt9L
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
