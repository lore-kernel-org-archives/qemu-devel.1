Received: from eggs.gnu.org ([2001:4830:134:3::10]:38548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eKsLE-000064-Oz
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 15:55:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eKsLD-0001Hu-GP
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 15:55:24 -0500
References: <20171116173810.16457-1-crosa@redhat.com>
	<20171116173810.16457-10-crosa@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <73d4f3e0-9d5f-7986-b0cd-73af0a75228d@redhat.com>
Date: Fri, 1 Dec 2017 21:55:12 +0100
MIME-Version: 1.0
In-Reply-To: <20171116173810.16457-10-crosa@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fEnRGdxDgnJ7lSGjaoQxbeTAQA1fU1SbI"
Subject: Re: [Qemu-devel] [PATCH 09/10] qemu-iotests: remove unused "here"
 variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fEnRGdxDgnJ7lSGjaoQxbeTAQA1fU1SbI
From: Max Reitz <mreitz@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <73d4f3e0-9d5f-7986-b0cd-73af0a75228d@redhat.com>
Subject: Re: [PATCH 09/10] qemu-iotests: remove unused "here" variable
References: <20171116173810.16457-1-crosa@redhat.com>
 <20171116173810.16457-10-crosa@redhat.com>
In-Reply-To: <20171116173810.16457-10-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-16 18:38, Cleber Rosa wrote:
> Another legacy variable that did not convince me it has any
> purpose whatsoever.
>=20
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---

Reviewed-by: Max Reitz <mreitz@redhat.com>


--fEnRGdxDgnJ7lSGjaoQxbeTAQA1fU1SbI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlohwbASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AYkoIAKT4r6tjlx3qUmuqDhNlHo5WPlg8FzVp
yKnVkjYloymv/8/YvQ73ike4GoBE/NXm9N9n1fzRXJpZPlNyG9SW8Q0D0R+CzTDZ
y1/p4Ws5Rp2/4DdUIpuCVqS+xpUAGGNtV0rJG2H2Jh7EdxJDYcJQ1WW+8PKM5XsP
Lb+8wjfbF59w18g7G8TVu1MCWMrcDWIISM46RqklOb6pd4/YaJA+FVKYMTcIJ8/8
18YFm9DO9SX/lGFCIzZXy07h6MIzgTbTEm+fi+Ei6HZhgjDwj28Y2EDr1gCHtkfg
c2dCuxzH2HInJSdZWaRWUGWnnaU0KnQZBxMEVBq8CoMs0DnDlsbtTzE=
=KfIg
-----END PGP SIGNATURE-----

--fEnRGdxDgnJ7lSGjaoQxbeTAQA1fU1SbI--
