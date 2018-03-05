Received: from eggs.gnu.org ([2001:4830:134:3::10]:47614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1essTl-0007md-SE
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:56:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1essTl-0007Is-66
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:56:45 -0500
References: <20180302134917.25526-1-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <53df9dc5-6cb0-c7ef-2c07-923e59aa9b60@redhat.com>
Date: Mon, 5 Mar 2018 16:56:37 +0100
MIME-Version: 1.0
In-Reply-To: <20180302134917.25526-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RYfixdFBa4jUehUBMb2BNiWOyngmitBRL"
Subject: Re: [Qemu-devel] [PATCH] iotests: Mark all tests executable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RYfixdFBa4jUehUBMb2BNiWOyngmitBRL
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
Message-ID: <53df9dc5-6cb0-c7ef-2c07-923e59aa9b60@redhat.com>
Subject: Re: [PATCH] iotests: Mark all tests executable
References: <20180302134917.25526-1-eblake@redhat.com>
In-Reply-To: <20180302134917.25526-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-02 14:49, Eric Blake wrote:
> The majority of our iotests have the executable bit set; fix the
> few outliers for consistency.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---

I think 124 is missing.

Max


--RYfixdFBa4jUehUBMb2BNiWOyngmitBRL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqdaLUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AenEIAK5mbyhN2ecM9sgpTVVxn0MNqHzBjrL/
6uJgAmjQfxYswmhjwCy5TjSNmdvurZ/CJ5NWMzTpJbSuWbjBSNzZlJF99oQexdsl
mOjto4P2B5CATMQ7zxhMv6zS6nxC7cxlCSQOUc7EqCRCwGCtxCLFpKCNtDudNfSv
t5hBVfSVudDDytFyAbHIA4peZ3tUQDwFPKEALUQynaxvJUpcom3kbCsUmzKxgC+v
AvjawtNgk5d24M8+4BYjN6uodU0t01wdpX8Y+nSOlf6nWCEThgC2KM1n4C3pZJgk
k3oZBQ8j3LXKfztY0kb0ZVkfr350LqT5nxw7b9ug1wwLSPXARYH76gQ=
=hjSk
-----END PGP SIGNATURE-----

--RYfixdFBa4jUehUBMb2BNiWOyngmitBRL--
