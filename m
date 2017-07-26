Received: from eggs.gnu.org ([2001:4830:134:3::10]:41026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1daLyx-0007so-3r
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:04:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1daLyw-000230-A0
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:04:07 -0400
Date: Wed, 26 Jul 2017 14:04:01 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170726130401.GI18489@stefanha-x1.localdomain>
References: <20170627154120.20346-1-stefanha@redhat.com>
	<20170724094614.GF4630@noname.str.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FUFe+yI/t+r3nyH4"
Content-Disposition: inline
In-Reply-To: <20170724094614.GF4630@noname.str.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] docs: add qemu-block-drivers(7) man page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, el13635@mail.ntua.gr


--FUFe+yI/t+r3nyH4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2017 at 11:46:14AM +0200, Kevin Wolf wrote:
> Am 27.06.2017 um 17:41 hat Stefan Hajnoczi geschrieben:
> > Extract the relevant part of qemu-doc.html into a new file called
> > docs/qemu-block-drivers.texi.  This file can also be built as a
> > stand-alone document (man, html, etc).
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: John Snow <jsnow@redhat.com>
>=20
> Looks good, but doesn't apply any more.
>=20
> A rebased version can still be included in QEMU 2.10, documentation
> improvements are fine during the freeze.

Thanks, I have sent v3 to resolve the conflict.

Stefan

--FUFe+yI/t+r3nyH4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZeJNAAAoJEJykq7OBq3PIp3gH/RdZC4Hb5CxtVweQphREHSd3
s1P14v8dQtzG6oSlPqrthzbHUmCZJhtY9apOHqWk2FQ3MQLqvi8YTEI6ASvTfWSN
0xGP3wby/66sfgwzq9zN2fMLoHDIcuZbCKcFsVmuWwgg836s71pXx5+yqx5azLg/
Z4aW3xk9vV3xfU2yl5f3ZYTltvWtr/UTrWAvNZvy16dxoA/SBqte1YSmubauB8R/
k29Lv8S5p0A0Ae8kNjyiTQTT0EtTycoBD0FVvDUlkSQEHnYh/bzIeo7jOGPQa0mX
fop1hzdQGE9Melow+DF9AbSJywgt86ECuT5jelkB5nc5e/WMxgANff0ngQdpQQs=
=vFV7
-----END PGP SIGNATURE-----

--FUFe+yI/t+r3nyH4--
