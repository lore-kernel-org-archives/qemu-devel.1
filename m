Received: from eggs.gnu.org ([2001:4830:134:3::10]:45536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cqyhL-0000Uu-KZ
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:06:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cqyhI-0000Vx-G3
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:06:23 -0400
Date: Thu, 23 Mar 2017 09:06:17 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170323090617.GO16717@stefanha-x1.localdomain>
References: <1490152052-9660-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="acOuGx3oQeOcSZJu"
Content-Disposition: inline
In-Reply-To: <1490152052-9660-1-git-send-email-jasowang@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] e1000: disable debug by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Leonid Bloch <leonid.bloch@ravellosystems.com>, Dmitry Fleytman <dmitry.fleytman@ravellosystems.com>, qemu-stable@nongnu.org


--acOuGx3oQeOcSZJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2017 at 11:07:32AM +0800, Jason Wang wrote:
> Disable debug output by default, the information were not needed for
> release.
>=20
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Stefan Hajnoczi <stefanha@gmail.com>
> Cc: Leonid Bloch <leonid.bloch@ravellosystems.com>
> Cc: Dmitry Fleytman <dmitry.fleytman@ravellosystems.com>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  hw/net/e1000.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--acOuGx3oQeOcSZJu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY05AJAAoJEJykq7OBq3PIY1cH/2FZUipprZc3WK61uetl6Ora
gJItl52iKrMNGMLo69RDm/lhmgnCCF7CKYKNBNaj4hHkzMJLVA2pfqB6JIZP8Yqv
LCIJvxWY7Ajih/o3bqrV9prrb26ENDvJPusgdbSHa/q6+batTfWdtj/UmsKhGynZ
4DquxhXh1+y/LwB7x66WC0QkY5I6NTnqjILXU40eO5hX0JY5zLfLj6YbHwek/yif
kBRT8VcHlKwVfaXef04ZQTPUkhF3Jya2J6Wggxb6pH0lupM9ekpKrtN0DgxEdn6y
CdgV1UUrA0W3aq9GkQ5ozTWjp6S5k8Brtj/lrchTKK7Hph5U1be1e9MLBb4iqFg=
=K3KD
-----END PGP SIGNATURE-----

--acOuGx3oQeOcSZJu--
