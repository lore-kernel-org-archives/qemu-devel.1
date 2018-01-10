Received: from eggs.gnu.org ([2001:4830:134:3::10]:52708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZLYL-0008BU-CW
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 13:56:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZLYK-0007f9-OV
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 13:56:45 -0500
Date: Wed, 10 Jan 2018 18:56:30 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180110185630.GG24212@stefanha-x1.localdomain>
References: <20180110091846.10699-1-famz@redhat.com>
	<20180110091846.10699-6-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Wtrm9ATX0sn6fFKv"
Content-Disposition: inline
In-Reply-To: <20180110091846.10699-6-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 5/9] block/nvme: Implement
 .bdrv_(un)register_buf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Karl Rister <krister@redhat.com>


--Wtrm9ATX0sn6fFKv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2018 at 05:18:42PM +0800, Fam Zheng wrote:
> Forward these two calls to the IOVA manager.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/nvme.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Wtrm9ATX0sn6fFKv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaVmHeAAoJEJykq7OBq3PIYp4H/318LOTHJFwSnIqdur4glVh9
YWHo1oeb5bBlq1URYt4CZbVXT+2Pz0GEtNlvuG4Fnh0jeH/XLmxJwkbC2WdNv8Js
AyEubvsdmeSfBC5ReM7widf495+fTiTyllaj4peQrAvNTQTCGmqO1nXp/clsE+ez
LOmepoSm26HHg8oTcS02g185UZHb2whmtQ5HFArse1uSArtuL/zI13oD2N2UMZGC
GdDZVBW6SostlSWT54KeyLN8Rf2u7UsVyvW33RYkNCUIQmi49ZnSSL6z50xdwcen
49zELnkgRm614nXvHFilhB4WMQU1bxIQQKSQMJzJif8VrZyVlW16u3ynn7WBmKs=
=w1Yd
-----END PGP SIGNATURE-----

--Wtrm9ATX0sn6fFKv--
