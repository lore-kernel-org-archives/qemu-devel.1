Received: from eggs.gnu.org ([2001:4830:134:3::10]:40688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drrt8-0004jo-9M
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 16:34:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drrt7-0000nC-9D
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 16:34:30 -0400
References: <20170912144459.11359-1-pbonzini@redhat.com>
	<20170912144459.11359-2-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a1d9ee91-55aa-899e-768c-daf1e940edaa@redhat.com>
Date: Tue, 12 Sep 2017 15:34:17 -0500
MIME-Version: 1.0
In-Reply-To: <20170912144459.11359-2-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CrXDwNr94gi7Wtfujtf8lgXe9vvosrXqI"
Subject: Re: [Qemu-devel] [PATCH 01/10] qemu-iotests: remove dead code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CrXDwNr94gi7Wtfujtf8lgXe9vvosrXqI
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <a1d9ee91-55aa-899e-768c-daf1e940edaa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/10] qemu-iotests: remove dead code
References: <20170912144459.11359-1-pbonzini@redhat.com>
 <20170912144459.11359-2-pbonzini@redhat.com>
In-Reply-To: <20170912144459.11359-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/12/2017 09:44 AM, Paolo Bonzini wrote:
> This includes shell function, shell variables and command line options
> (randomize.awk does not exist).
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/qemu-iotests/check         | 28 -----------------
>  tests/qemu-iotests/common        | 23 --------------
>  tests/qemu-iotests/common.config | 26 ---------------
>  tests/qemu-iotests/common.rc     | 68 --------------------------------=
--------
>  4 files changed, 145 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--CrXDwNr94gi7Wtfujtf8lgXe9vvosrXqI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm4RMkACgkQp6FrSiUn
Q2pRSQf7BRwH6HAv9zkezJbNsk24n+vv3jcBcCYFzspn0OWpbB3o05++96p3I9uo
8mM4Bttdax7UDnSRLc+bFAit6kU2WCv402tGFar74YCjXKU8k9IdaB3odQeb/v2i
q271lYyZENQbxy8r02jsoyymo2RDIa9rfC5A4o663ilu/19JjUllcwfXv6HCS8iX
kg2KBCY0a2cthACVw2asGRQDvfeA2fN37rqKX6tAdZxvF3KiQZvE+WLqlCLxYxEC
dW1d3i4gW+GqRX2ECvAZNxFH9tl/SrcsWZyuv7/9yFOqBGTl9mGLrlGLpcR0rN2g
CAaLFiRDV2qQ0tYj0JIGmdrNfIl0iQ==
=umVv
-----END PGP SIGNATURE-----

--CrXDwNr94gi7Wtfujtf8lgXe9vvosrXqI--
