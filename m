Received: from eggs.gnu.org ([2001:4830:134:3::10]:39604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cT7Mz-0001pS-5S
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:30:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cT7Mu-0001Oz-U8
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:30:45 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cT7Mu-0001Og-Mf
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:30:40 -0500
Received: by mail-wm0-x241.google.com with SMTP id r144so30860810wme.0
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 05:30:40 -0800 (PST)
Date: Mon, 16 Jan 2017 13:30:36 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170116133036.GD14681@stefanha-x1.localdomain>
References: <1484256713-10902-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a2FkP9tdjPU2nyhF"
Content-Disposition: inline
In-Reply-To: <1484256713-10902-1-git-send-email-mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: drop an obsolete comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org


--a2FkP9tdjPU2nyhF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 12, 2017 at 11:31:56PM +0200, Michael S. Tsirkin wrote:
> virtio core has code to revert queue number
> to maximum on reset. Drop TODO to add that.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/virtio/virtio-pci.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--a2FkP9tdjPU2nyhF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYfMr8AAoJEJykq7OBq3PIPd0IAIL/z2aeNIvssMvLhwMQI5bw
Eht9L77cVHZpzZDnxMdB/yw7CdqFIs1HddlBqKw7I57xbOL42RKm63HN0zyl+0Gw
ecxXsK7I9qgzjBAvoUh0BZtFGSzVziPSBatSnkc3/IAF1euxsmqpfNrFI4hv/zHL
rnaXKg6W6JDwgyzPHIOUbC4bH+E2935lTodKvrJyzO/qplfp3afy/P/V1Dt9I3NA
coSSb+j0F5KAl4w5lyw9ytQJkjIuwLk72WjKRor177Si1AbckHVdfqTDRe9DgZXn
9G0brZbS3GbcV92fFk9KnnwWyaxVhcF24p/xJ6kVJSFJD1ofeH5+iYYCHrAfPJ0=
=6Nv/
-----END PGP SIGNATURE-----

--a2FkP9tdjPU2nyhF--
