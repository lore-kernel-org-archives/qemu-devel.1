Received: from eggs.gnu.org ([2001:4830:134:3::10]:46141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cyk0F-00005N-3H
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 15:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cyk0B-0000g3-TW
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 15:01:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1cyk0B-0000fC-GG
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 15:01:55 -0400
References: <1491405505-31620-1-git-send-email-den@openvz.org>
	<1491405505-31620-2-git-send-email-den@openvz.org>
	<74131dfa-9cd8-4d0c-6d2c-6a87358159bc@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <66db5ca9-bf22-af36-b4bf-790df991fcd0@redhat.com>
Date: Thu, 13 Apr 2017 21:01:50 +0200
MIME-Version: 1.0
In-Reply-To: <74131dfa-9cd8-4d0c-6d2c-6a87358159bc@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5O07M1s9hffdBgv0PFKX0Tecg90qWDAWS"
Subject: Re: [Qemu-devel] [PATCH 1/2] block: fix obvious coding style
 mitakes in block_int.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Klim Kireev <proffk@virtuozzo.mipt.ru>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5O07M1s9hffdBgv0PFKX0Tecg90qWDAWS
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Klim Kireev <proffk@virtuozzo.mipt.ru>
Message-ID: <66db5ca9-bf22-af36-b4bf-790df991fcd0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] block: fix obvious coding style mitakes
 in block_int.h
References: <1491405505-31620-1-git-send-email-den@openvz.org>
 <1491405505-31620-2-git-send-email-den@openvz.org>
 <74131dfa-9cd8-4d0c-6d2c-6a87358159bc@redhat.com>
In-Reply-To: <74131dfa-9cd8-4d0c-6d2c-6a87358159bc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.04.2017 17:35, Eric Blake wrote:
> On 04/05/2017 10:18 AM, Denis V. Lunev wrote:
>> From: Klim Kireev <proffk@virtuozzo.mipt.ru>
>=20
> s/mitakes/mistakes/ in the subject
>=20
> A blank commit message body doesn't help - the subject says what was
> changed but not why (for example, output of checkpatch.pl without the
> patch applied); and details may help in grepping past history when
> looking for the change or even to justify that the change is not just c=
hurn.
>=20
>>
>> Signed-off-by: Klim Kireev <proffk@virtuozzo.mipt.ru>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Kevin Wolf <kwolf@redhat.com>
>> CC: Max Reitz <mreitz@redhat.com>
>> ---
>>  include/block/block_int.h | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>=20
> At any rate, all of the changes (the fact that we prefer binding the
> pointer operator * to the name on the right rather than the type on the=

> left) look sane.

I know someone who disagrees but that someone also knows that I will
support and accept this kind of patches gladly. O:-)

Max

> Reviewed-by: Eric Blake <eblake@redhat.com>


--5O07M1s9hffdBgv0PFKX0Tecg90qWDAWS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljvyx4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A4K8H/A8hs+ysI5kl9lRf3TBYb+iGQl00hpr7
tjSYrxLa+ByGeZOBvdZAfE0HAVrjJZFWS/q3O/wkrGG2JgU6jAKBwtzIN3R6CPK+
W7WcEB+hOOxDBlbYy7LDRrOeXlRt2RF86hyWS7f0x2R5vFgBAlbiZLcokmdJpbJ6
BUJ8t857Bnw3anSxgJGV9f5oS5/xtiWGnX7nJYJL5teC0WpQD/KQD6h6c9PC7lQD
z8xorze6G1csNeYGSos5AAtyZtMlk2Cfuz/TcYDwOPmsmGHwp1GInkYw/3TNGcRf
U3gjzgZQRsJaydRbUae2t+Ha11hbYPAl14nUGgjJTQM/raiLc3jrqKE=
=cMjq
-----END PGP SIGNATURE-----

--5O07M1s9hffdBgv0PFKX0Tecg90qWDAWS--
