Received: from eggs.gnu.org ([2001:4830:134:3::10]:45488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fC4Yv-0000Xf-KE
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 10:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fC4Yr-0003Oh-N2
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 10:41:25 -0400
References: <20180427111502.9822-1-dgilbert@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7fd850c9-e757-40a0-457c-aaf0d813ccfa@redhat.com>
Date: Fri, 27 Apr 2018 09:41:12 -0500
MIME-Version: 1.0
In-Reply-To: <20180427111502.9822-1-dgilbert@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sTgRYxpTqf4Qs7uR7JGrDPJijlAOgOQhz"
Subject: Re: [Qemu-devel] [PATCH] migration: Textual fixups for blocktime
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sTgRYxpTqf4Qs7uR7JGrDPJijlAOgOQhz
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Message-ID: <7fd850c9-e757-40a0-457c-aaf0d813ccfa@redhat.com>
Subject: Re: [PATCH] migration: Textual fixups for blocktime
References: <20180427111502.9822-1-dgilbert@redhat.com>
In-Reply-To: <20180427111502.9822-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/27/2018 06:15 AM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Blank lines and comments as suggested by Eric.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  qapi/migration.json | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--sTgRYxpTqf4Qs7uR7JGrDPJijlAOgOQhz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrjNogACgkQp6FrSiUn
Q2oNhQgAkIoncgEaag+8MHErU0SLOASIkxtc/HlZ5sMDGjcU0X1K4hXSphTsGzfl
MlztykbyJDjCq/nkpWuDBEJIcIOuIablTS23eV391UnckuhW5eTPKFs5bTALxMQ1
1dmhrJ50jVMauC0F1JgR1EadwDtPPC+un99XzJCy+I7IbClqRzmoWowiTc8TMO+O
nMnCn8iz4URoPMtrk4CHMxJh/aGsOWPsS8hD/SihBryHaBjdLbtDFS62ePV7rGB7
L6/RyxA+F8PAttODVRLHXpBwSjPyFugL+GaPUet/g9g8Da2WgrfUXlnep94oRUa0
6HEV3c1sXKBVlFhqh1Sz3dT4gcQsrA==
=Rme/
-----END PGP SIGNATURE-----

--sTgRYxpTqf4Qs7uR7JGrDPJijlAOgOQhz--
