Received: from eggs.gnu.org ([2001:4830:134:3::10]:54610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTVsp-0001a9-2J
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 12:13:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTVsl-0006Iu-4l
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 12:13:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dTVsk-0006IJ-Ru
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 12:13:27 -0400
References: <20170707152918.23086-1-vsementsov@virtuozzo.com>
	<5b1660d6-5329-7578-3f00-ac22b7552c91@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <685708d1-92f3-6295-f00a-82b4a248ef0e@redhat.com>
Date: Fri, 7 Jul 2017 11:13:21 -0500
MIME-Version: 1.0
In-Reply-To: <5b1660d6-5329-7578-3f00-ac22b7552c91@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Cj1m8JtNfR6a8hrJi9XltHVfJp0EHKo6p"
Subject: Re: [Qemu-devel] [PATCH v3 00/10] nbd refactoring part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, berrange@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Cj1m8JtNfR6a8hrJi9XltHVfJp0EHKo6p
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, berrange@redhat.com, den@openvz.org
Message-ID: <685708d1-92f3-6295-f00a-82b4a248ef0e@redhat.com>
Subject: Re: [PATCH v3 00/10] nbd refactoring part 2
References: <20170707152918.23086-1-vsementsov@virtuozzo.com>
 <5b1660d6-5329-7578-3f00-ac22b7552c91@redhat.com>
In-Reply-To: <5b1660d6-5329-7578-3f00-ac22b7552c91@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/07/2017 11:06 AM, Paolo Bonzini wrote:
>=20
>=20
> On 07/07/2017 17:29, Vladimir Sementsov-Ogievskiy wrote:
>> This is last part of "nbd errors and traces refactoring".
>>
>> Patches 01-10 from "nbd errors and traces refactoring" are already mer=
ged.
>> Patches 11-13 from it are rejected - do not regret them.
>> So, these series is update of 14-19 patches from "nbd errors and trace=
s
>> refactoring"
>=20
> Looks good---Eric, want to send a pull request yourself?

Aha - I see where this is going.  I'll submit a patch to MAINTAINERS to
propose myself as the new active maintainer of all things NBD, and then
figure out (off-list, with Paolo's help) how to submit this as my first
PULL request.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Cj1m8JtNfR6a8hrJi9XltHVfJp0EHKo6p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZX7MhAAoJEKeha0olJ0NqkC0H/0EoywkmJSMuqvl46DoYPttm
s/oDj80ZR+90jK6d2qP7jq9nxsiHzxjx8YFCuJBOj//oM+JaCabb6eGMli8xGlrc
n+J/FiPr/QR5n66cy/tLPJQdc7Hn8YN7QHHrU8/RkyH81YbGqXagnaFFOhIw9uHY
py6SGEHBrWXoHZHD2Ka0teGo/1263tPgDBvK7EZWTTVZX6OI3p6B20Beg2lPbWf7
1fYxJ6mf/y9aIkVs41j13s+dvFsU0Crxf8oojuWw33SLVRNkG4Julnsx5a5Cx8RD
95rq15TtDoanlEd1vQSJYjkLBN+SKrDALxNLc20J+9dAKxvAZdk9cBju3pg14u8=
=+1FR
-----END PGP SIGNATURE-----

--Cj1m8JtNfR6a8hrJi9XltHVfJp0EHKo6p--
