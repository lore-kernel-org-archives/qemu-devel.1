Received: from eggs.gnu.org ([2001:4830:134:3::10]:59647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cq7xY-0007IP-NB
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 20:47:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cq7xV-0000Pv-KB
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 20:47:36 -0400
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ab2687a8-27d5-6d3f-1fd9-575158e05f85@redhat.com>
Date: Mon, 20 Mar 2017 19:47:30 -0500
MIME-Version: 1.0
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CmNOqhD09A7673u1I2q321kJ7H356r7k0"
Subject: Re: [Qemu-devel] [PATCH 00/81] Patch Round-up for stable 2.8.1,
 freeze on 2017-03-27
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CmNOqhD09A7673u1I2q321kJ7H356r7k0
From: Eric Blake <eblake@redhat.com>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Message-ID: <ab2687a8-27d5-6d3f-1fd9-575158e05f85@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/81] Patch Round-up for stable 2.8.1,
 freeze on 2017-03-27
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/20/2017 06:07 PM, Michael Roth wrote:
> Hi everyone,
>=20
> The following new patches are queued for QEMU stable v2.8.1:
>=20
>   https://github.com/mdroth/qemu/commits/stable-2.8-staging
>=20
> The release is planned for 2017-03-30:
>=20
>   http://wiki.qemu.org/Planning/2.8
>=20
> Please respond here or CC qemu-stable@nongnu.org on any patches you
> think should be included in the release.

Needs:

Vladimir Sementsov-Ogievskiy (1):
2563c9c      nbd/client: fix drop_sync [CVE-2017-2630]


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--CmNOqhD09A7673u1I2q321kJ7H356r7k0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0HgiAAoJEKeha0olJ0Nq65IH/ib19fXyExpHn69QckuKisvj
3ME1xsqCnbWOOvpyGLjgae+w2sLn+LpKiO76o1i7jPfcYN1UUDcQ4yeuiNS9yq39
RJvb7KIjaUcaVmK49QYfZd+gnIuGy6tUEDVP2hgZg1hTLFugkNgPB0DCDJyRoVta
eoIZgy421zalfymT2+TwOFVym4dKDEGw208vw7aTHYGHcgbmXmuJVTX0c7fPR2B0
suc9xdBE1BtNRjmegpxaywisPnz83K9A+AkuwJN+FIuWPvIKMkFPBhQlpruRezB0
OKUFxbqGp+YT9YSAdZCN+GMJbYuXLnczsMcUUe1lBtwRTcgo2AY40mMaNd5Hf+A=
=33ri
-----END PGP SIGNATURE-----

--CmNOqhD09A7673u1I2q321kJ7H356r7k0--
