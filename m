Received: from eggs.gnu.org ([2001:4830:134:3::10]:35793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eHh0K-00081L-Ib
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 21:12:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eHh0J-0003uK-Q4
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 21:12:40 -0500
References: <20171123020832.8165-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8203a018-6404-a872-136b-2766882c8c4d@redhat.com>
Date: Thu, 23 Nov 2017 03:12:26 +0100
MIME-Version: 1.0
In-Reply-To: <20171123020832.8165-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nEs7d3MVl5Gv7J8sM3v5Q1NxMwS27gHWx"
Subject: Re: [Qemu-devel] [PATCH 00/17] iotests: Fix iotests for weird
 formats/options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nEs7d3MVl5Gv7J8sM3v5Q1NxMwS27gHWx
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>
Message-ID: <8203a018-6404-a872-136b-2766882c8c4d@redhat.com>
Subject: Re: [PATCH 00/17] iotests: Fix iotests for weird formats/options
References: <20171123020832.8165-1-mreitz@redhat.com>
In-Reply-To: <20171123020832.8165-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-23 03:08, Max Reitz wrote:
> This series fixes the qemu-iotests for qcow, vmdk, qcow2 v2 and qcow2 v=
3
> with refcount_bits=3D1.

(By the way, excuse me for calling vmdk a weird format.  That was
supposed to be a joke.

(I know explaining a joke makes it unfunny, but I now feel a bit bad for
it.)

Max)


--nEs7d3MVl5Gv7J8sM3v5Q1NxMwS27gHWx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloWLooSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AO38H/A934hGLcq7GWCKjKJ+VPsLULpQyw8RI
fT5wZf/1LXUe2jLHTE2teVZ4se6dv5cuze19bjKBTvC7/8HW6ghTjCeWAYMWLSQh
LAw5ViZgqt7VNF26hD84jw+Yv8bEJmXq/nqtAqDE6oaJ9gd0guF2yjU6EemihQQv
CZIOSSsDh1UE9r0VyYfvwJBCzxo991mBZePDZcuaIgJj6HgrVVAlS7Fq1DbED/FD
I2DpqaF8nulPkb9TT4ltBKdlk0KDentiv/zl0QH49EgIYUXnUVQbC9ORmegY8RAq
rewg+UiPFBSJ8409OjDyNIEQrJsDciYf7xbLXPL0lJT7jAMmm29YnJc=
=DSfz
-----END PGP SIGNATURE-----

--nEs7d3MVl5Gv7J8sM3v5Q1NxMwS27gHWx--
