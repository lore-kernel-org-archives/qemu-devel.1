Received: from eggs.gnu.org ([2001:4830:134:3::10]:53939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbFr7-00040H-7d
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 19:11:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbFr6-0005r4-Ay
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 19:11:29 -0500
References: <20170123123056.30383-1-famz@redhat.com>
	<20170123123056.30383-8-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5f7d3fbe-feed-afe0-ddca-b09f4c20ca24@redhat.com>
Date: Wed, 8 Feb 2017 01:11:19 +0100
MIME-Version: 1.0
In-Reply-To: <20170123123056.30383-8-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9tGNKOubXGW8leGPV82WK5kC49q1g462s"
Subject: Re: [Qemu-devel] [PATCH v12 07/16] iotests: 030: Read-only open
 image for getting map
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9tGNKOubXGW8leGPV82WK5kC49q1g462s
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org,
 eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com
Message-ID: <5f7d3fbe-feed-afe0-ddca-b09f4c20ca24@redhat.com>
Subject: Re: [PATCH v12 07/16] iotests: 030: Read-only open image for getting
 map
References: <20170123123056.30383-1-famz@redhat.com>
 <20170123123056.30383-8-famz@redhat.com>
In-Reply-To: <20170123123056.30383-8-famz@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 23.01.2017 13:30, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/qemu-iotests/030 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

(As always, took a couple of retries to let test 030 pass for me...)


--9tGNKOubXGW8leGPV82WK5kC49q1g462s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliaYicSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AbyEH/1HunCPgwtyFLLQRJY2NAib7CTuk2+jX
lR6aXfq5j/rZArXVXMwIC9cX194q8zz4HJfHyl2YYjC1TOLZcuC6130MjjSu5Tis
psil/KyCa91ux/IALx7elrYZaZ8zHA/gJL/+RpwFNebdMvjcxGB723Ei2Fa8j/tQ
SsZOMUjPe8DxpbODSTxQhxmVpjVdiT9ld/VTBCERuOG0dF71zbh930DWIQ4N1UR5
kSCLtdv2DTVxOmI8HdMJZe/5SV7X+zD43LQX/9oJ7YWmXS3PuhCGNauhSopQ85Nv
i4FCg7X6VkGmHwsoZUe1qRNzo4RXkUnJRm2z8UTgYHE/z72xvL9wJvg=
=DTAm
-----END PGP SIGNATURE-----

--9tGNKOubXGW8leGPV82WK5kC49q1g462s--
