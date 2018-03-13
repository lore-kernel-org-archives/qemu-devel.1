Received: from eggs.gnu.org ([2001:4830:134:3::10]:59489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evlKq-0004rX-CU
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:55:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evlKl-0001sU-Nq
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:55:28 -0400
References: <20180313144730.2184-1-kwolf@redhat.com>
	<20180313144730.2184-6-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <610aa1f2-6e9a-0733-7081-6f46420129dd@redhat.com>
Date: Tue, 13 Mar 2018 15:55:06 +0100
MIME-Version: 1.0
In-Reply-To: <20180313144730.2184-6-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ltzLueM9CcKRtMSudDvniPMFSHFg9Mqcf"
Subject: Re: [Qemu-devel] [PATCH v2 5/8] vdi: Make comments consistent with
 other drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: den@openvz.org, jcody@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ltzLueM9CcKRtMSudDvniPMFSHFg9Mqcf
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: den@openvz.org, jcody@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org
Message-ID: <610aa1f2-6e9a-0733-7081-6f46420129dd@redhat.com>
Subject: Re: [PATCH v2 5/8] vdi: Make comments consistent with other drivers
References: <20180313144730.2184-1-kwolf@redhat.com>
 <20180313144730.2184-6-kwolf@redhat.com>
In-Reply-To: <20180313144730.2184-6-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-13 15:47, Kevin Wolf wrote:
> This makes the .bdrv_co_create(_opts) implementation of vdi look more
> like the other recently converted block drivers.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/vdi.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--ltzLueM9CcKRtMSudDvniPMFSHFg9Mqcf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqn5koSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AUsoH/i0aS8BTYpSAjpKvdfhhuo7xeSzHUhMS
3dzD3Ls9qmYqu9jAghNAljmRx754sIPjZ7qYiiFPGj0IIemHdSRATcYWK1I3Cn8o
SAVKAozDGtG5tmDb/Sy3bF6QI7Bu6ALQtsPkSak7pcaxL+G9n1cS33Z46oRD6M3c
A3iAlQ6bsu8fLZRn13BOjD0IEMCX0fM7lMWi8GSL0EzsTgfYtz3JV9HNfyZ35rKK
Ukox7ZQi12hGEGgUe2rLDEeIq2za5HdYNExgRU8SJXJR7mnRvwsNb5PqLqh8zeYF
qqmwrYVje4buOKY20FIyfq8vp2Z7osHgM98GXvWzBND+UH5YoBqRJA0=
=0X0g
-----END PGP SIGNATURE-----

--ltzLueM9CcKRtMSudDvniPMFSHFg9Mqcf--
