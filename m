Received: from eggs.gnu.org ([209.51.188.92]:41178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpdD7-0006C2-9x
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 13:06:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpdCq-0006VQ-Jr
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 13:06:27 -0500
References: <20190201173655.4567-1-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c669dce9-ea5c-3f36-8d05-647abbee738f@redhat.com>
Date: Fri, 1 Feb 2019 12:06:16 -0600
MIME-Version: 1.0
In-Reply-To: <20190201173655.4567-1-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="l880JIMxKEer7aXS5I0l6vXpJkjcdjvr0"
Subject: Re: [Qemu-devel] [PATCH] qemu-common.h: Update copyright string for
 2019
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l880JIMxKEer7aXS5I0l6vXpJkjcdjvr0
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <c669dce9-ea5c-3f36-8d05-647abbee738f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-common.h: Update copyright string for
 2019
References: <20190201173655.4567-1-peter.maydell@linaro.org>
In-Reply-To: <20190201173655.4567-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/1/19 11:36 AM, Peter Maydell wrote:
> Update the copyright string we use in version/help output,
> since we're well into the new year now.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Better than last year, where we didn't get round to doing
> the year bump until September :-)

And at least this time, done before we release :)

> ---
>  include/qemu-common.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--l880JIMxKEer7aXS5I0l6vXpJkjcdjvr0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxUipgACgkQp6FrSiUn
Q2rHKwf/XU5KrdL/Zk3jHbyVyec6XcZiqSHscrBHmuwxjwu1wAyJGrLSbrv6MSFE
I7Rs6Zrw9WGpdw7Q2kbIHXcf24p0bqVtAc09IgROfIr3D9wJRC9HC0uvDWiCOUho
14wnNeriqU8uXVD7h99qUROY4IdkX5w+YvIi3o0fy3zlfKQXIln4gFGMOkWALCBr
gHYGiczdCpsF4m8tDhadPXbL+tX23z+o3HjgcvBx+6IYqGpA9RWC+u3huppy/Q2F
tfnWrYZeNXm+qFERsHra7yXfjeI0yzMh8EybCPxXBo/iPTM/QHj959wS7FCsrgtM
kofOY3YFY8MJkVP6Q5VPtdXH3cK7vg==
=Octj
-----END PGP SIGNATURE-----

--l880JIMxKEer7aXS5I0l6vXpJkjcdjvr0--
