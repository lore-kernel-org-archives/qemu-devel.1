Received: from eggs.gnu.org ([2001:4830:134:3::10]:51561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdktx-0002hZ-MT
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 16:44:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdktw-0006kb-Ie
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 16:44:45 -0500
References: <1487091579-67092-1-git-send-email-vsementsov@virtuozzo.com>
	<905517d4-8064-b4b8-d6b5-f697104f2170@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a1394648-afc7-5256-f41f-9559026712fa@redhat.com>
Date: Tue, 14 Feb 2017 15:44:34 -0600
MIME-Version: 1.0
In-Reply-To: <905517d4-8064-b4b8-d6b5-f697104f2170@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VWsAlrcEeamriMFvxWSQVXr81EgEcEprf"
Subject: Re: [Qemu-devel] [PATCH v14 00/24] qcow2: persistent dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VWsAlrcEeamriMFvxWSQVXr81EgEcEprf
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org, pbonzini@redhat.com
Message-ID: <a1394648-afc7-5256-f41f-9559026712fa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v14 00/24] qcow2: persistent dirty bitmaps
References: <1487091579-67092-1-git-send-email-vsementsov@virtuozzo.com>
 <905517d4-8064-b4b8-d6b5-f697104f2170@redhat.com>
In-Reply-To: <905517d4-8064-b4b8-d6b5-f697104f2170@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/14/2017 01:02 PM, John Snow wrote:
>=20
>=20
> On 02/14/2017 11:59 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all!
>>
>=20
> Hi! :)
>=20
>> There is a new update of qcow2-bitmap series - v14.
>>
>=20
> Having the cover letter be 00/24 but including 25 patches confuses the
> patch scraping tool a good deal. Also, can you include the "v14" in the=

> patch emails themselves, too?

If you do have a reason for v15, using 'qemu send-email -v15 ...' should
automatically put the prefix on all the mails.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--VWsAlrcEeamriMFvxWSQVXr81EgEcEprf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYo3pCAAoJEKeha0olJ0NqhmwH/jb766w9oIWIkBOaC9cGIJhJ
5KkwGLzOVszXvp2/dv0tDdEWYcpzLhaCqNcx6UXPOT+uZ62LBZt3+meqf7kTawPP
pOVMFeNutJCaQPnLALarfvG6XHCp6rWrx/h3icLc4zTCwH03alij/J/6BGhqN5Zh
2z9A6+KPZwaJRQQFltuW9eQ0jVJZDJIWIEvCYDxuauXcsLXtPRx42K1ka+jUa5wQ
XyeJI7kc7cDQa6QLShDehhrtHYFsV/KzULGpoGVDbSEhL5hTJimOqznfCl7W+40S
Cz2e8CELl91XA+gPZRsO9OYY1QVocYsVEXPeCUs4R/LPhbyQ1PgjuSAqF8haKRc=
=tNPE
-----END PGP SIGNATURE-----

--VWsAlrcEeamriMFvxWSQVXr81EgEcEprf--
