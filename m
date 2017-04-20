Received: from eggs.gnu.org ([2001:4830:134:3::10]:44758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d10Xu-0006yR-Rl
	for Qemu-devel@nongnu.org; Wed, 19 Apr 2017 21:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d10Xr-000747-Nu
	for Qemu-devel@nongnu.org; Wed, 19 Apr 2017 21:06:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d10Xr-00073d-HS
	for Qemu-devel@nongnu.org; Wed, 19 Apr 2017 21:06:03 -0400
From: Eric Blake <eblake@redhat.com>
Message-ID: <6e650412-7a28-f924-4405-de1640505dfb@redhat.com>
Date: Wed, 19 Apr 2017 20:06:00 -0500
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EkjJ5hUEsiP2Ekh103c078IPaqN0FGREV"
Subject: [Qemu-devel] ppc MAINTAINERS update needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>, Scott Wood <scottwood@freescale.com>, Alexander Graf <agraf@suse.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EkjJ5hUEsiP2Ekh103c078IPaqN0FGREV
From: Eric Blake <eblake@redhat.com>
To: "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>,
 Scott Wood <scottwood@freescale.com>, Alexander Graf <agraf@suse.de>
Message-ID: <6e650412-7a28-f924-4405-de1640505dfb@redhat.com>
Subject: ppc MAINTAINERS update needed
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The sections for e500, mpc8544ds, and ppce500 all list Scott Wood as a
co-maintainer, but I'm getting bounce emails for scottwood@freescale.com
as an unknown address.  What is the appropriate tweak needed to the
MAINTAINERS file?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--EkjJ5hUEsiP2Ekh103c078IPaqN0FGREV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY+Al4AAoJEKeha0olJ0Nq0bUH/2eegBsZNm3trPvHbWJTP1iM
0W5vLLULEk9oJaxRRd61ERr4ZFUSYfmIm5A+5Zh+NHiR+25LxNlAEAgDTck81oHb
x27z8pGVhpp8yUH9lwUKhLCW8Hi1yOptt7GG7G/vz6F0YP3jGzKMtSnWFxNGXIVl
xuCtRCWTja5lfjD9V7XPk6B/ubtw6DkagbHXNqMaMjqD9ha3H3poXhfgibX046Ag
/5VeZkYqS8n590ylnhSFpJvdoHJxnH5/obuYnrXenUMixMRtGTgUwc9pVYIMbGdN
M50h/GwaKBGxy7qUrG9k70S4gZOz5OuynGJw4cl3R27cLEZXvp4YrvuW0ttlZIU=
=C0Fy
-----END PGP SIGNATURE-----

--EkjJ5hUEsiP2Ekh103c078IPaqN0FGREV--
