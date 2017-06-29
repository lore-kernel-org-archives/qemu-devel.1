Received: from eggs.gnu.org ([2001:4830:134:3::10]:33047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQb6v-0000Ol-HN
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:12:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQb6u-0003If-IC
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:12:01 -0400
References: <20170628175534.14295-1-eblake@redhat.com>
	<4e6a11e8-d2f9-faa0-8203-9421c79224f3@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aa0a6484-f676-bf9f-393c-be6e9e5ed8b8@redhat.com>
Date: Thu, 29 Jun 2017 10:11:47 -0500
MIME-Version: 1.0
In-Reply-To: <4e6a11e8-d2f9-faa0-8203-9421c79224f3@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7EoXI80R7R2XpE0k1PQrclrMPl1ASv0ts"
Subject: Re: [Qemu-devel] [PATCH v3 00/11] make dirty-bitmap byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7EoXI80R7R2XpE0k1PQrclrMPl1ASv0ts
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aa0a6484-f676-bf9f-393c-be6e9e5ed8b8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/11] make dirty-bitmap byte-based
References: <20170628175534.14295-1-eblake@redhat.com>
 <4e6a11e8-d2f9-faa0-8203-9421c79224f3@virtuozzo.com>
In-Reply-To: <4e6a11e8-d2f9-faa0-8203-9421c79224f3@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/29/2017 03:28 AM, Vladimir Sementsov-Ogievskiy wrote:
> Hi!
>=20
> Can we apply my "[PATCH v22 00/30] qcow2: persistent dirty bitmaps"
> first? It was already near to the victory a week ago, but I had to
> rebase it on new Paolo's patches.

Sure, I can rebase on top of yours (I've already rebased multiple times,
as have you, but yours has been on the list longer).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--7EoXI80R7R2XpE0k1PQrclrMPl1ASv0ts
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZVRizAAoJEKeha0olJ0NqdkcH/AkpMNxHspFTU6rnkmVQQ0H6
7wkRlBXkoxqiVoz36iU33Siccan3IM5eOHUxwu53gJUPypcxPG636754+kY4WuNV
WTsHv4TIraWZaW1yD9AXxBtxV0m6opUOqrxk5gyVzh0x83+MKhZoav1aceA++Ynw
RCYEtC+wgRjNmy6KJtI1L4L8Km+mJWD2rRo/HYAIO+7SAhkUb7tF9YqVsiAeScC/
9awHEzpgMxHMFph1L3chlxE9/xjwmaQhzmPfFJLg9aSyGFsJDuHjAciG0RwOZS73
jkSlaTm2kAErfBKrWDZVfhP1onaf8a/yJI/wy0Gjw1a5Ocit1tAZ/D6vkuYnzSg=
=TkRi
-----END PGP SIGNATURE-----

--7EoXI80R7R2XpE0k1PQrclrMPl1ASv0ts--
