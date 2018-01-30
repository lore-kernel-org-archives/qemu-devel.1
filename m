Received: from eggs.gnu.org ([2001:4830:134:3::10]:60220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egWJj-0007RQ-HI
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 08:51:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egWJe-0007EN-0O
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 08:51:19 -0500
References: <20180130063433.11605-1-famz@redhat.com>
	<20180130063433.11605-2-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <13824a1d-435a-d182-da35-f4a2b42ea39e@redhat.com>
Date: Tue, 30 Jan 2018 07:50:58 -0600
MIME-Version: 1.0
In-Reply-To: <20180130063433.11605-2-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iXfKZqjgFNzji4HQH16vJr5MIicDAzWFj"
Subject: Re: [Qemu-devel] [PATCH v6 1/2] qemu-img.texi: Clean up parameter
 list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, kchamart@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iXfKZqjgFNzji4HQH16vJr5MIicDAzWFj
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, kchamart@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <13824a1d-435a-d182-da35-f4a2b42ea39e@redhat.com>
Subject: Re: [PATCH v6 1/2] qemu-img.texi: Clean up parameter list
References: <20180130063433.11605-1-famz@redhat.com>
 <20180130063433.11605-2-famz@redhat.com>
In-Reply-To: <20180130063433.11605-2-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2018 12:34 AM, Fam Zheng wrote:
> Split options out of the "@table @var" section and create a "@table
> @option", then use whitespaces and blank lines consistently.
>=20
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  qemu-img.texi | 66 +++++++++++++++++++++++++++++++++++----------------=
--------
>  1 file changed, 39 insertions(+), 27 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--iXfKZqjgFNzji4HQH16vJr5MIicDAzWFj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpweEIACgkQp6FrSiUn
Q2qg7AgAo8XirpmolOG2Hf4lEVDqBBWH7ceX7inQt3+YBrQgeC0SkQ/FztwP/XGT
3SslB+nkV44NLJeFpvHO68Vm+3wt5Gwo6/S5R0+TyolHQcFSo33ErIls1YITWpgO
6PHjeOj0BXChiKeU+QJx12ewJKKOImWwOKDrJxVU4tkuThizh2IP/meonS85bIuJ
BqFMkW9yXnaC2J85YZZ8gI8rsTr4tF6lDnXUj7zSeWSY8bQavv2QM+urzQe7HehN
BjN21C3cXeBqmAHbg9iFEYJ/vPM39wXq3F1J4f5iv6LsoIpq4ElpiTT1LauRmKGp
En/eTGHHH6w+PQZ8UfPjDGUsjL0ilg==
=+ECv
-----END PGP SIGNATURE-----

--iXfKZqjgFNzji4HQH16vJr5MIicDAzWFj--
