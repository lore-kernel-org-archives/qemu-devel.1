Received: from eggs.gnu.org ([2001:4830:134:3::10]:34479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ctBaV-0002qw-3C
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 07:16:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ctBaR-0002jI-W7
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 07:16:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ctBaR-0002iR-Po
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 07:16:23 -0400
Date: Wed, 29 Mar 2017 12:16:20 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170329111620.GH10462@stefanha-x1.localdomain>
References: <20170328225327.16707-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bpVaumkpfGNUagdU"
Content-Disposition: inline
In-Reply-To: <20170328225327.16707-1-samuel.thibault@ens-lyon.org>
Subject: Re: [Qemu-devel] [PULL 0/3] slirp updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: qemu-devel@nongnu.org, jan.kiszka@siemens.com


--bpVaumkpfGNUagdU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 29, 2017 at 12:53:24AM +0200, Samuel Thibault wrote:
> The following changes since commit df9046363220e57d45818312759b954c033c58=
ab:
>=20
>   Update version for v2.9.0-rc2 release (2017-03-28 19:11:16 +0100)
>=20
> are available in the git repository at:
>=20
>   http://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>=20
> for you to fetch changes up to a2f80fdfc683019901cdf4c0863a5920c0ca7245:
>=20
>   slirp: Send RDNSS in RA only if host has an IPv6 DNS server (2017-03-29=
 00:51:25 +0200)
>=20
> ----------------------------------------------------------------
> slirp updates
>=20
> ----------------------------------------------------------------
> Laurent Vivier (1):
>       slirp: fix compilation errors with DEBUG set
>=20
> Samuel Thibault (2):
>       slirp: Make RA build more flexible
>       slirp: Send RDNSS in RA only if host has an IPv6 DNS server
>=20
>  slirp/ip6_icmp.c | 47 ++++++++++++++++++++++-------------------------
>  slirp/slirp.c    |  2 +-
>  2 files changed, 23 insertions(+), 26 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--bpVaumkpfGNUagdU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY25eEAAoJEJykq7OBq3PIUaAIAI8OaGi/4ZxZ+46dNb3T5ML5
qYrgi9zCoKXEGmSLs3O3cDEEEL6DmyeMzSpV/AGtrw30ieBzORfMjuP/gYICwXuI
VyWjuqJAMgKYmAYX4f+1vWndtAPCZOQ6xa6+PtOvGcF7dLeR8l1ScGel2o8xw02p
UVlxrRTg6JoBrRhbZOvJu/39e7i0MXyR2Q1LDMVk55GBcMihiAwWy3J92wxQmExK
zA035KzN/X3eDpkdhClJjVLzgtWktn229MMo2DjKcLh56wsBL0/F/0FwoY4rqzIG
VlIRd3f0WQw7J6MMQxhCH0H7dIUtQ4gk5p/rrGAJv6yU5y0Ypj5gkq9PIWMYe9A=
=iCxI
-----END PGP SIGNATURE-----

--bpVaumkpfGNUagdU--
