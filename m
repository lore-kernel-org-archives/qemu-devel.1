Received: from eggs.gnu.org ([2001:4830:134:3::10]:33831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcA7w-0004j1-8t
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:48:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcA7s-0004qw-9X
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:48:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dcA7s-0004q5-0d
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:48:48 -0400
References: <20170729131159.24949-1-vsementsov@virtuozzo.com>
	<20170729131159.24949-4-vsementsov@virtuozzo.com>
	<20170731092606.GD11830@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cce442b5-c483-b6ea-e0cf-63005c0cb51c@redhat.com>
Date: Mon, 31 Jul 2017 07:48:41 -0500
MIME-Version: 1.0
In-Reply-To: <20170731092606.GD11830@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="D20lE2AGxhF6aOXuokuG1mM70oBWFjjng"
Subject: Re: [Qemu-devel] [PATCH v2 3/4] checkpatch: check trace-events code
 style
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mreitz@redhat.com, jsnow@redhat.com, den@openvz.org, peter.maydell@linaro.org, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D20lE2AGxhF6aOXuokuG1mM70oBWFjjng
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mreitz@redhat.com,
 jsnow@redhat.com, den@openvz.org, peter.maydell@linaro.org,
 berrange@redhat.com
Message-ID: <cce442b5-c483-b6ea-e0cf-63005c0cb51c@redhat.com>
Subject: Re: [PATCH v2 3/4] checkpatch: check trace-events code style
References: <20170729131159.24949-1-vsementsov@virtuozzo.com>
 <20170729131159.24949-4-vsementsov@virtuozzo.com>
 <20170731092606.GD11830@stefanha-x1.localdomain>
In-Reply-To: <20170731092606.GD11830@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/31/2017 04:26 AM, Stefan Hajnoczi wrote:
> On Sat, Jul 29, 2017 at 04:11:58PM +0300, Vladimir Sementsov-Ogievskiy =
wrote:
>> Accordingly to CODING_STYLE, check that in trace-events:

s/Accordingly/According/

>> 1. hex numbers are prefixed with '0x'
>> 2. '#' flag of printf is not used
>> 3. The exclusion from 1. are period-separated groups of numbers
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> ---
>>  scripts/checkpatch.pl | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--D20lE2AGxhF6aOXuokuG1mM70oBWFjjng
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll/JyoACgkQp6FrSiUn
Q2q4dwgAoOMOc8SCSVZILPe+OpRVhs0MJxryESDn4RjjvGAqqqPgqXBTtVfpUNgN
1PCd6l1ZM3aUO9U3vp/tzwrqDSyMkx9f3naFo/Ib0D2nx5O+0l8PDj3YxdvSZLWd
mqAeJiXb6bjN4Gf6k1YHi+L7XeB4qBA2OEtJFy4ntRM3ERsxk58NXoywwo6vfbVZ
GZrNEyB3EzK/oNCn8Re7VrJHX4nrE6WgkIKUSxPHyq0kEtZoW8+pfuzvdjAc/eSN
qXrLPGA3xUJ9KFZueayzXdeVi2nzv3JCb5IA8yFVbW2zHxIUE1rO4o4Q28K7zhOj
L8yrJlhQSBFxMR6L67ugmWLaUkS81Q==
=Hf3c
-----END PGP SIGNATURE-----

--D20lE2AGxhF6aOXuokuG1mM70oBWFjjng--
