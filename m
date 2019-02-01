Received: from eggs.gnu.org ([209.51.188.92]:40094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gpRBH-0002pV-4n
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 00:15:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gpRBG-0007Et-JL
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 00:15:59 -0500
Date: Fri, 1 Feb 2019 13:15:47 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190201051547.GF23131@stefanha-x1.localdomain>
References: <20190131151914.164903-1-sgarzare@redhat.com>
	<20190131151914.164903-6-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/aVve/J9H4Wl5yVO"
Content-Disposition: inline
In-Reply-To: <20190131151914.164903-6-sgarzare@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/5] tests/virtio-blk: add test for
 WRITE_ZEROES command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>


--/aVve/J9H4Wl5yVO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 31, 2019 at 04:19:14PM +0100, Stefano Garzarella wrote:
> If the WRITE_ZEROES feature is enabled, we check this command
> in the test_basic().
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  tests/virtio-blk-test.c | 60 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--/aVve/J9H4Wl5yVO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcU9YDAAoJEJykq7OBq3PIRaEH/0masjU9/e9T9OeA+3OuLHB4
LUwHRv8oiNmh3+B3BuWGKno42k269lrMw+mD4j4KK65coC8xhxCzOqBQ8s9T+mMm
poLCfuGaEaRh39Yeu12J6glT6p+tYsOPCbO2qldUIP6TaOPHCr7neame6KvFDzpK
z6zRcKxs1R7BiA8y/IyGz+JYz98+9koKRi5k2EKYD+ADMWWWhG/bjoYvAj6GoaFq
vXlWiJVIL5xDChlqIKOUGWdLzSxfcXqNcsNEYKtXkCotLjOVNFEOfpPHauc+KQhF
gk1OKs81x5lPR52HzQbb4495PPHW+mWNLX4DiR7umz/yZQp0TyhnaVilBrsgD3A=
=QJ2t
-----END PGP SIGNATURE-----

--/aVve/J9H4Wl5yVO--
