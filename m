Received: from eggs.gnu.org ([2001:4830:134:3::10]:40666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwuMC-0005YE-B1
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwuM8-0004dC-FH
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:13:20 -0400
References: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ab207a61-7c4e-270b-0427-d8310c8d5b89@redhat.com>
Date: Tue, 26 Sep 2017 13:13:14 -0500
MIME-Version: 1.0
In-Reply-To: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qt0pt3inPTS0xl6T1wmtwhJV1dImmdTuu"
Subject: Re: [Qemu-devel] [PATCH 00/12] Patch Round-up for stable 2.10.1,
 freeze on 2017-09-27
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
--qt0pt3inPTS0xl6T1wmtwhJV1dImmdTuu
From: Eric Blake <eblake@redhat.com>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Message-ID: <ab207a61-7c4e-270b-0427-d8310c8d5b89@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/12] Patch Round-up for stable 2.10.1,
 freeze on 2017-09-27
References: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/19/2017 07:45 PM, Michael Roth wrote:
> Hi everyone,
>=20
> The following new patches are queued for QEMU stable v2.10.1:
>=20
>   https://github.com/mdroth/qemu/commits/stable-2.10-staging
>=20
> The release is planned for 2017-10-02:
>=20
>   https://wiki.qemu.org/Planning/2.10
>=20
> Please respond here or CC qemu-stable@nongnu.org on any patches you
> think should be included in the release.
>=20

I just cc'd qemu-stable for 3c2d5183f9f, nbd-client: avoid read_reply_co
entry if send failed

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qt0pt3inPTS0xl6T1wmtwhJV1dImmdTuu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnKmLoACgkQp6FrSiUn
Q2o99QgAgoeNX0dnZqO3MbGj/PeWLI0geS90a9bpHbyiEpqC1HTSUm/JA97DamXw
x3L1E/XvLvJMsK5ACwO5rRbvjBaqyV+kxtk5+bIUsEW3i41e6hMrjLoeYMECvEsB
3IM0fE+DlrcU8TG1BHIbfVkd7/PxpxLJj6K0y/pia5NmleMwc/t37RBdGXOEyIL+
y+3sGWPHupe/UC9uGkNcry9uoPjYqzXoc7K5od05uMUccDfy+yAN4MAhx217n1Ay
mkV0dJrd9ygAFTZMytDEZORPInZhM0KK0RPC1AZVeLDRd7nx8YvtVfF7gkO285ce
jNz3AcKFPhH/PtbwDiBOzPreCvLlpw==
=7N2I
-----END PGP SIGNATURE-----

--qt0pt3inPTS0xl6T1wmtwhJV1dImmdTuu--
