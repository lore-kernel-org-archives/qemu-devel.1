Received: from eggs.gnu.org ([2001:4830:134:3::10]:59231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dl0R2-0004Af-S1
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 18:17:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dl0Qz-00026B-Kg
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 18:17:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1dl0Qz-00025o-Am
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 18:17:05 -0400
References: <mailman.3749.1503600836.21955.qemu-devel@nongnu.org>
	<74846968-830E-4239-9DC7-B1252A5AC946@gmail.com>
	<60e13112-931d-a517-ddb1-20c2f2de736e@redhat.com>
	<9CE89958-B59C-4D3C-91C5-ECB4B153C43D@gmail.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <89d8b7b1-fb0f-a967-927e-8795c7d2b324@redhat.com>
Date: Thu, 24 Aug 2017 18:16:57 -0400
MIME-Version: 1.0
In-Reply-To: <9CE89958-B59C-4D3C-91C5-ECB4B153C43D@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KgEfHeG631iDTNK5r8LB9ponTN4wH7LdJ"
Subject: Re: [Qemu-devel] Make test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KgEfHeG631iDTNK5r8LB9ponTN4wH7LdJ
From: Cleber Rosa <crosa@redhat.com>
To: Programmingkid <programmingkidx@gmail.com>
Cc: qemu-devel@nongnu.org
Message-ID: <89d8b7b1-fb0f-a967-927e-8795c7d2b324@redhat.com>
Subject: Re: [Qemu-devel] Make test
References: <mailman.3749.1503600836.21955.qemu-devel@nongnu.org>
 <74846968-830E-4239-9DC7-B1252A5AC946@gmail.com>
 <60e13112-931d-a517-ddb1-20c2f2de736e@redhat.com>
 <9CE89958-B59C-4D3C-91C5-ECB4B153C43D@gmail.com>
In-Reply-To: <9CE89958-B59C-4D3C-91C5-ECB4B153C43D@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/24/2017 05:50 PM, Programmingkid wrote:
>=20
> Thank you for the patches. I will test them. I was wondering what is th=
e point to having both 'make check' and 'make test'. It looks like everyo=
ne is using 'make check'. Maybe we are better off removing the 'make test=
' target.
>=20

I think the removing the `make test` target is a good thing, if its
tests are either absorbed by an existing `make check*` one.  Now that
depends on what people think the tcg tests (and others) deserve... TLC?
Total annihilation?

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]


--KgEfHeG631iDTNK5r8LB9ponTN4wH7LdJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAlmfUFkACgkQZX6NM6Xy
CfPujg/9EVcUOT259vYz8ThW1mg3aMrvHYsk9t6gEUSYvX0Z0NfQU4FURri1SZE6
VFZePm9QcBPz1Km8YZQ0xSvf/y+wuIu/xHwa2cQeoP2W1OHiuCFI5Lw8AQG1tWIo
wj6Dr3JEiiwSKPdsOuf6z+oZrM/+zjbQuhEciXbvBHm3u7Uv+ss8cIxms3fsPOWr
fzLJTq4RKW+rY7yz3Y4KiPPGBlxIu6DsMcWPJSMp3Iar2eQxIny2h8mh+/m+9kSf
EMYom1XnD9Ud93D3A+hkbdlaqhEpKJdPSRpNnm3jYzRFcZkbrP+Vv5I4wxq47wHJ
LfTVkTndtmDaJjlUbhbI1NwTcrZv/ZBYBrp9oGneW3YxSvul6kDgpSeR0vC/YIA6
ZPuwFCJmLre/l6z6IaMz9XUfLiZRs/B/oXiaOJji9V845UTm2mNKWXmfWWD0fq10
ZtVICnc+8CsxuslVSss5BzM038Cj7fSDSn8cEl3TVRloA4XLZnnir7/I7mmY9rdP
uQw9iquf89YBtkMhu9auCDvjswfqFxZtUp0BILaF2wZQtD9w0saEBG6lC+x2h97t
kHrlHkxCUCgqKREVeAItI7U8NCMsDoltt20z/T6pikQLUIKQjLBeMTJAfOXz79R3
RWIkkzAlSzYRsXMEyXFcZYuVggEHcXHuChtL+ZAjwkdjuuR0GP4=
=wwRR
-----END PGP SIGNATURE-----

--KgEfHeG631iDTNK5r8LB9ponTN4wH7LdJ--
