Received: from eggs.gnu.org ([2001:4830:134:3::10]:58317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eF5K4-0001iE-QM
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 16:34:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eF5K4-0007yX-0A
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 16:34:16 -0500
References: <151078101230.405.4178905747947844592@bafd83ae6430>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c4c090fc-7fda-c2ea-d36e-e3d801b7881e@redhat.com>
Date: Wed, 15 Nov 2017 15:34:06 -0600
MIME-Version: 1.0
In-Reply-To: <151078101230.405.4178905747947844592@bafd83ae6430>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0SExD0TOir6LA6b1euhdaedD8FKqSqAdN"
Subject: Re: [Qemu-devel] [PATCH for-2.11] nbd/server: Fix error reporting
 for bad requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0SExD0TOir6LA6b1euhdaedD8FKqSqAdN
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org
Message-ID: <c4c090fc-7fda-c2ea-d36e-e3d801b7881e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11] nbd/server: Fix error reporting for
 bad requests
References: <151078101230.405.4178905747947844592@bafd83ae6430>
In-Reply-To: <151078101230.405.4178905747947844592@bafd83ae6430>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/15/2017 03:23 PM, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed build test on s390x host. Please find the details be=
low.

EPEBCAK. Serves me right for tweaking the patch in between
compile-testing and posting.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0SExD0TOir6LA6b1euhdaedD8FKqSqAdN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloMss4ACgkQp6FrSiUn
Q2qC0wgArEsRhgdI/DOYk+vVxJ7PuQCw4L9hcVAFQ1E4QL2QUxW8oNVJJF492Ffk
5IkbPaAxD1tKajpLCYaV54V2P2ytEvCekMlwsbodo05WgLCOj4IIH8txcOqeB6W9
Jn3QGXIFdt7ZDMTvwrTKKbgVFlGYXlmLU3P+nlg9NqCdK7w+tUbJP670O/i3J7HK
DKn9OO7TlGY56Zovce8LHJ8KMkm/MbWI6r+S8F/mhlIEEwDcMipDGyi1tGCnT7bs
0dZ3NNVspkyZmEXu8IxSUlBNYDRDKi9iphJ2gtVmJ//fqygdhDjsbcTNe32TM3iM
dkfz+3LVA55ZcteT2+4hlRILUc944Q==
=OGGY
-----END PGP SIGNATURE-----

--0SExD0TOir6LA6b1euhdaedD8FKqSqAdN--
