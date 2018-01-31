Received: from eggs.gnu.org ([2001:4830:134:3::10]:46268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egxz1-0008LX-Bm
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:23:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egxz0-0003Xw-DQ
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:23:47 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<9f551b36d688079dcda4838c788f41a190b5219c.1516978645.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5f6f4efd-6076-5e38-7491-020b034d8c18@redhat.com>
Date: Wed, 31 Jan 2018 13:23:37 -0600
MIME-Version: 1.0
In-Reply-To: <9f551b36d688079dcda4838c788f41a190b5219c.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hgE3QoGmKmijzbHOhi6ynHUT2PRUvvpO6"
Subject: Re: [Qemu-devel] [PATCH v3 39/39] iotests: Add l2-cache-entry-size
 to iotest 137
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hgE3QoGmKmijzbHOhi6ynHUT2PRUvvpO6
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <5f6f4efd-6076-5e38-7491-020b034d8c18@redhat.com>
Subject: Re: [PATCH v3 39/39] iotests: Add l2-cache-entry-size to iotest 137
References: <cover.1516978645.git.berto@igalia.com>
 <9f551b36d688079dcda4838c788f41a190b5219c.1516978645.git.berto@igalia.com>
In-Reply-To: <9f551b36d688079dcda4838c788f41a190b5219c.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/26/2018 09:00 AM, Alberto Garcia wrote:
> This test tries reopening a qcow2 image with valid and invalid
> options. This patch adds l2-cache-entry-size to the set.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  tests/qemu-iotests/137     | 5 +++++
>  tests/qemu-iotests/137.out | 2 ++
>  2 files changed, 7 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--hgE3QoGmKmijzbHOhi6ynHUT2PRUvvpO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpyF7kACgkQp6FrSiUn
Q2oT2wf/RCfT6TxbsLtvl3KpHR6e1loFX0YGzMDNjCmP3m3dN8j7TfKyhU+hboGz
138vx6sy0cOPdHfUFg2EbvMOq4bJY9zIUWlMUX8metZo4zBvw05hpWFPF0oWBFhY
0/6YIr6E/YiYjFHHFhtqbmrqSWyoCu5+dSP98XW2A1rcybEawgkt/HcUX4zCORHQ
w+i1Y2LNwUwuC++YjqLeCzAYb7ByCTuvIRfwGQ76AS6DgvJXB7vcFZJtZHX8QU6L
LGsoDk9UFMgu5QfJDDuCpVnvkPwRCGNUGWt9PactMqKxMHQ6OQ00dXravWzcXnn2
+hBonuX8DhSnKf4vIweR9sTBl3D1Xg==
=F2HE
-----END PGP SIGNATURE-----

--hgE3QoGmKmijzbHOhi6ynHUT2PRUvvpO6--
