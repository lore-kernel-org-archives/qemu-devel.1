Received: from eggs.gnu.org ([2001:4830:134:3::10]:50126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dYZgA-00055h-HV
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:17:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dYZg7-0002BJ-An
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:17:22 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:36065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dYZg7-00029y-1P
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:17:19 -0400
Received: by mail-wm0-x232.google.com with SMTP id w191so11031248wmw.1
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 08:17:18 -0700 (PDT)
Date: Fri, 21 Jul 2017 16:17:14 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170721151714.GH18014@stefanha-x1.localdomain>
References: <20170717081152.17153-1-lprosek@redhat.com>
	<20170717081152.17153-10-lprosek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aF3LVLvitz/VQU3c"
Content-Disposition: inline
In-Reply-To: <20170717081152.17153-10-lprosek@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 9/9] checkpatch: add virtio_error and
 virtqueue_error to error funcs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel@nongnu.org, casasfernando@hotmail.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, armbru@redhat.com, groug@kaod.org, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com


--aF3LVLvitz/VQU3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2017 at 10:11:52AM +0200, Ladi Prosek wrote:
> Two more error functions that should not contain newlines.
>=20
> Suggested-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> ---
>  scripts/checkpatch.pl | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--aF3LVLvitz/VQU3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZchr6AAoJEJykq7OBq3PIj1IIAKyW9DMo12wFQBL7N6wpCSsH
yLoIeOJvctcHXLr0IktQaIWGFowXAvHGIEPFQhJdUx+FqHWjy1NJF7ScxPM0Y6AQ
JXZWfSTzJSrDge9IRMi9HaaB10zsqwfXxWy5qCozCfccN3YBdmjJ7h6b6vUVHs3D
ZceM/e9rPrivvxwiwNxgpmY+XBqC8gRJ8A1ycRDiyzWzAwilTjYQuPj3R2Mz1lst
r33PV3xcUXXo9emhnIWx/XFFDB9zDHP2Yknhc3XMXT9b2znqx9yhq+kju67fQNVq
RYox/rA7YKiSGedW3BvBLofSdZqeSMgUjEsMotR5W8vbOywm8PgWEfgVOSfbdbo=
=J+id
-----END PGP SIGNATURE-----

--aF3LVLvitz/VQU3c--
