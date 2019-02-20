Received: from eggs.gnu.org ([209.51.188.92]:44371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gwUTM-0007DF-Fi
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:11:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gwUTL-000816-2e
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:11:48 -0500
Date: Wed, 20 Feb 2019 16:11:42 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190220161142.GG30403@stefanha-x1.localdomain>
References: <20190218140301.197408-1-sgarzare@redhat.com>
	<20190218140301.197408-11-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IuhbYIxU28t+Kd57"
Content-Disposition: inline
In-Reply-To: <20190218140301.197408-11-sgarzare@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 10/10] tests/virtio-blk: add test for
 DISCARD command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--IuhbYIxU28t+Kd57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 18, 2019 at 03:03:01PM +0100, Stefano Garzarella wrote:
> If the DISCARD feature is enabled, we try this command in the
> test_basic(), checking only the status returned by the request.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  tests/virtio-blk-test.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--IuhbYIxU28t+Kd57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcbXw+AAoJEJykq7OBq3PI7z0IAIf2Feqga33HQxdA2x1xKr0P
AS5MBCy1nicIP7UrKlaCfJs+AtZOYzrv3p92UBkSV0p70F63+wdkfcLW+vCmrCZv
TpuFKJlJ0JzrkO/MDfxoUspDy/a228eyq+wE4WTADfbms1jk7xladQfK23z+lAm0
pAaDy2+ydWkgt5/X/CQCy1V0vjiGeZQ0VO7llcl6Ov6bZ1Tie31PyKT3QSiAKocx
qRzrqF2rUagWYs6rJzBs6m+XJct45fVres0Y1mWCb38WPmIbkD0emHnX7zop98Sc
4mFBtCZ7WA7rhuUWAUt2kOkgPmdHk4hk6YiDndxHuIXtL07MJvsjqfVnnZh7hiQ=
=bNf+
-----END PGP SIGNATURE-----

--IuhbYIxU28t+Kd57--
