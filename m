Received: from eggs.gnu.org ([2001:4830:134:3::10]:39409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZ0PO-0001DV-LJ
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 15:22:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZ0PN-0000ep-Mf
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 15:22:06 -0500
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
	<20171207155102.66622-5-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2ef24ffc-c649-6b04-5753-83336843e057@redhat.com>
Date: Tue, 9 Jan 2018 14:21:56 -0600
MIME-Version: 1.0
In-Reply-To: <20171207155102.66622-5-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fean2bvVAWAu8vs43KP5j8mh871Q4wcQd"
Subject: Re: [Qemu-devel] [PATCH v2 4/6] iotest 147: add cases to test new
 @name parameter of nbd-server-add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fean2bvVAWAu8vs43KP5j8mh871Q4wcQd
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com,
 mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <2ef24ffc-c649-6b04-5753-83336843e057@redhat.com>
Subject: Re: [PATCH v2 4/6] iotest 147: add cases to test new @name parameter
 of nbd-server-add
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
 <20171207155102.66622-5-vsementsov@virtuozzo.com>
In-Reply-To: <20171207155102.66622-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/07/2017 09:51 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/147     | 68 +++++++++++++++++++++++++++++++++++++-=
--------
>  tests/qemu-iotests/147.out |  4 +--
>  2 files changed, 57 insertions(+), 15 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--fean2bvVAWAu8vs43KP5j8mh871Q4wcQd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpVJGQACgkQp6FrSiUn
Q2pZhwf8D1M+eU/kWg5BBGAnCpz/QmrM9W8YPXYup22aB4WhsCSzlRQrjId4lC/i
1uUszXMG/fmDyd7Hnj1GPvVrZHPvaUWVsRTjsfOwP34uMx00NMSSlRxFDomSsRf+
nNwUXe0wxgZQvKJwFq0hXkb8a9kzVizV8Fd3sAXBG2E8LEuTli6jvCxGGj3mGrR+
x9EpTURcONwRNmtgi9xXp0SsIyLs7ogthY0Lh3F/Vv/QvsL5JLQ02diDzI9dGwZo
qe0i1XKoF8lHaJ3cRpVS3TbBfa4C4Sdo4VCWCklAdaj+DzZg8/Kun+UzBUAW3Ave
9fbEOR6J2yAmjeZPFGVSuJdWOpqgmw==
=IdGu
-----END PGP SIGNATURE-----

--fean2bvVAWAu8vs43KP5j8mh871Q4wcQd--
