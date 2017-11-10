Received: from eggs.gnu.org ([2001:4830:134:3::10]:46574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDHTU-00032s-U5
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 17:08:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDHTU-0003UB-26
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 17:08:32 -0500
References: <cover.1510339534.git.berto@igalia.com>
	<e089c66e7c20289b046d782cea4373b765c5bc1d.1510339534.git.berto@igalia.com>
	<w51fu9lpz41.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bf17024e-e1ca-715c-821b-d366496ec1f6@redhat.com>
Date: Fri, 10 Nov 2017 23:08:20 +0100
MIME-Version: 1.0
In-Reply-To: <w51fu9lpz41.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QmkuuofHTHLF5BFwXF7Msu4w3kwF8TtAr"
Subject: Re: [Qemu-devel] [PATCH 2/3] block: Leave valid throttle timers
 when removing a BDS from a backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, sochin jiang <sochin.jiang@huawei.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QmkuuofHTHLF5BFwXF7Msu4w3kwF8TtAr
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, sochin jiang <sochin.jiang@huawei.com>
Message-ID: <bf17024e-e1ca-715c-821b-d366496ec1f6@redhat.com>
Subject: Re: [PATCH 2/3] block: Leave valid throttle timers when removing a
 BDS from a backend
References: <cover.1510339534.git.berto@igalia.com>
 <e089c66e7c20289b046d782cea4373b765c5bc1d.1510339534.git.berto@igalia.com>
 <w51fu9lpz41.fsf@maestria.local.igalia.com>
In-Reply-To: <w51fu9lpz41.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-10 23:06, Alberto Garcia wrote:
> On Fri 10 Nov 2017 07:54:47 PM CET, Alberto Garcia <berto@igalia.com> w=
rote:
>=20
> I just noticed a typo in the commit message:
>=20
>> There'a a couple of problems with this:
>=20
> "There's a couple"
>=20
> If there's no v2 of this series you can correct this when committing.

Well, the issue is that it's going to be interesting to commit this
because it depends on Stefan's tree now...

Maybe this series can go through his as well?

Max


--QmkuuofHTHLF5BFwXF7Msu4w3kwF8TtAr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloGI1QSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AA24H/05QsJewSif8bD852c5QNZm0JH5HAK11
VDNNIO+bH2LK6yB7GyrmjHVejKkJkh3f7MTZEt4QEffVYOTMF8VDxIvz19QBrpKn
bNa90b1DBIpvGJvglHT3NGQGOD1viW8u6U9wyLWTLjWofYyQ1//mw3gYOg3QAnvC
krGsMPtVjrPv4BQIUeuGosq7RVtSWOJC1ajpb/ocoHwkfCZlUbs+sxqXzPzccypU
IFSSqwwbSPc65CA9cxa2Ni9dGhscamj+EW+r4xbWdQYIigulSEPKfb/AuH9rvCQ3
sQRRXxpewZ33klxyDnGObyPhMnqOtUfsXqpespWjb3enY5fP0Ivmd6c=
=x4BH
-----END PGP SIGNATURE-----

--QmkuuofHTHLF5BFwXF7Msu4w3kwF8TtAr--
