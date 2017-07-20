Received: from eggs.gnu.org ([2001:4830:134:3::10]:45953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dYAsL-0004Yk-N2
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:48:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dYAsK-0002fd-Rb
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:48:17 -0400
Date: Thu, 20 Jul 2017 13:48:08 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170720124808.GE32383@stefanha-x1.localdomain>
References: <20170717142620.6970-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3XA6nns4nE4KvaS/"
Content-Disposition: inline
In-Reply-To: <20170717142620.6970-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: Remove a few tests from 'quick'
 group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, berrange@redhat.com, Kevin Wolf <kwolf@redhat.com>


--3XA6nns4nE4KvaS/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2017 at 09:26:20AM -0500, Eric Blake wrote:
> A run of './check -qcow2 -g quick' on my machine produced only
> two tests that took longer than 5 seconds; 178 took 18, and
> 189 took 7.  Remove them from the quick group.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/qemu-iotests/group | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--3XA6nns4nE4KvaS/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZcKaIAAoJEJykq7OBq3PI02sH+wXxPEawXR5uUrlZZHFTBRuw
KSGNuRfh5QzhVyGA17RLkSeepxT6k9+UNp6rvZUbj2JArL+HKI31M1IA+UpdlWg6
cNjWBeZdLwm3Od0YvQX+QJMntC6hSJQRje+rGE1KdHIE82WBf6s7kl2z4GP+YNk0
YW4COkFKcHUnijMj+AlBosNOTQlCUXgLrAzdOWkAyM2BJrhPgZku2zwmK5/+wFjy
tCoR5jVj5iGGP0ztGRsj3oW/ZQjPy6sqcuMTENLMhob4HlFeq0ITbgB+bkXGWxpV
IQNvelei+talBo3x2Q6B3HykblChuk9i4xF8yF0Th+SmFxk2qyhJLFbRMBr2IAw=
=OM71
-----END PGP SIGNATURE-----

--3XA6nns4nE4KvaS/--
