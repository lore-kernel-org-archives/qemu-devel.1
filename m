Received: from eggs.gnu.org ([209.51.188.92]:44154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grOGK-0003P6-Gk
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 09:33:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grOGJ-0002r5-Rh
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 09:33:16 -0500
References: <1549448589-381285-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1549448589-381285-4-git-send-email-andrey.shinkevich@virtuozzo.com>
	<c879b17e-11d6-bf58-0151-81f1e973a963@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <397db752-6a3f-fe86-a0c3-f9ee8d2a7efa@redhat.com>
Date: Wed, 6 Feb 2019 08:33:10 -0600
MIME-Version: 1.0
In-Reply-To: <c879b17e-11d6-bf58-0151-81f1e973a963@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EON1TG8EjIiiKN2FRyneFuG7b804uiKI9"
Subject: Re: [Qemu-devel] [PATCH v13 3/3] qcow2: list of bitmaps new test 242
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Denis Lunev <den@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EON1TG8EjIiiKN2FRyneFuG7b804uiKI9
From: Eric Blake <eblake@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Denis Lunev
 <den@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <397db752-6a3f-fe86-a0c3-f9ee8d2a7efa@redhat.com>
Subject: Re: [PATCH v13 3/3] qcow2: list of bitmaps new test 242
References: <1549448589-381285-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1549448589-381285-4-git-send-email-andrey.shinkevich@virtuozzo.com>
 <c879b17e-11d6-bf58-0151-81f1e973a963@virtuozzo.com>
In-Reply-To: <c879b17e-11d6-bf58-0151-81f1e973a963@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/6/19 5:58 AM, Andrey Shinkevich wrote:

>> +
>> +def add_bitmap(bitmap_number, persistent, disabled):
>> +    granularity =3D 2**(13 + bitmap_number)
>=20
> I wish I wrote:
>      granularity =3D 1 << (13 + bitmap_number)

Sure, that's easy to squash in.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--EON1TG8EjIiiKN2FRyneFuG7b804uiKI9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxa8CYACgkQp6FrSiUn
Q2p2Bgf/UrUjfqofSaXMmJ8V/mkZwq8VrUpIEuIHLMkofAu0WlyUfDPplsmHnpMb
kwggf7v/mMwpZUf9Y6n+82Li0tyXtfREy27IDIE2QoFjAAN43zyKVI7EkY3sJ/dX
FTzgTpeMsczWKzePQInlCHVUkM4Sdimod+V2cH0qzRWuM6ryHu6+PBdas92gDNVD
+dBm7p21mz2hghYo7Vy387555gXXhnVq2QpzYQGZHR7Ou0dIoSj49m6qIMBbY7f/
SQEymgOJ2FG0vxKbhTlgYHLvsJ0UeTVC7tDrVBoNUavvY3rsYxY/SvUthQNy2xVN
o107TthSbeJ2okw/kYJ2B2IAF0jdUA==
=Mg/o
-----END PGP SIGNATURE-----

--EON1TG8EjIiiKN2FRyneFuG7b804uiKI9--
