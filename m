Received: from eggs.gnu.org ([2001:4830:134:3::10]:54418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1evh95-0002o6-Lz
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 06:27:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1evh94-0006Br-QX
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 06:27:03 -0400
Date: Tue, 13 Mar 2018 10:26:53 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180313102653.GB16582@stefanha-x1.localdomain>
References: <20180312132204.23683-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
In-Reply-To: <20180312132204.23683-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: add include/block/aio-wait.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 12, 2018 at 01:22:04PM +0000, Stefan Hajnoczi wrote:
> The include/block/aio-wait.h header file was added by commit
> 7719f3c968c59e1bcda7e177679dc765b59e578f ("block: extract
> AIO_WAIT_WHILE() from BlockDriverState") without updating MAINTAINERS.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Thanks, applied to my block-next tree:
https://github.com/stefanha/qemu/commits/block-next

Stefan

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJap6dtAAoJEJykq7OBq3PIGMAIALdo1dlM6nEWXBa+tJjfv7nF
rj2+9yAGbpe55iE+duJjFpPjmqKhudETjYreCCsqzUM39R2uAuar6h271ttFvsFt
L7bHJL24qX0YGfCOj5Q9jYo+3gFBCcWCCkClPpLpQsGidIJCOTcYpI5o+GyjTkNR
+E2CG1HUb1mPKFe18sVob/YNEt01YmodIUb/lhc8fFNNBuBFlfCdgaLs0Q2Trbj4
tbSTjT2Szhaxp+f8bAKgshfEBKZqB40dA6bi9gZwenO9mhpWmGOcm/2Uynpv4Tvs
+MwbUBKRZHsb39MakY61fX1uR+j1P+0BzZWuMxswVt3AwUqkKnXwzjYYo2SofoM=
=J0/v
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
