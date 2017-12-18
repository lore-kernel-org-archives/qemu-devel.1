Received: from eggs.gnu.org ([2001:4830:134:3::10]:54096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQvcq-0005lA-71
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:38:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQvcm-0003hv-4q
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:38:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eQvcl-0003h3-V0
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:38:32 -0500
Date: Mon, 18 Dec 2017 13:38:27 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171218133827.GE16653@stefanha-x1.localdomain>
References: <1513350170-20168-1-git-send-email-den@openvz.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PGNNI9BzQDUtgA2J"
Content-Disposition: inline
In-Reply-To: <1513350170-20168-1-git-send-email-den@openvz.org>
Subject: Re: [Qemu-devel] [PATCH v3 0/2] virtio: fix IO request length in
 virtio SCSI/block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>


--PGNNI9BzQDUtgA2J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2017 at 06:02:48PM +0300, Denis V. Lunev wrote:
> v2->v3
> - added 2.12 machine types
> - added compat properties for 2.11 machine type
>=20
> v1->v2:
> - added max_segments property for virtblock device
>=20
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: "Michael S. Tsirkin" <mst@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Richard Henderson <rth@twiddle.net>
> CC: Eduardo Habkost <ehabkost@redhat.com>
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--PGNNI9BzQDUtgA2J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaN8TTAAoJEJykq7OBq3PIy3MH/2foa3kp9biBRi31UDK+0ISI
7Xy4iqDleGX/jxYgtqq/ZHqQfJrkbTWrnQdR6248vDn8YwB+a8xmPRiW+4rQsaF6
DhUYUTG7amZ6AhHi/xxkDejnFWCsyS/AxO9XHIcrzzWGq/bLGtGWkg271NQJJ+yt
BJIRd05aS55umh2RqLLAOv/FT2KNx+8pW82bT4XUfRWWa0aaeuH6l5qbR11gr7HV
BVnodvl4NOozHY9+ibT5zdpH/69hQCC+n4NBWjUQOG7RZnoyDF1TkU/fwQwGihuJ
WfLJk8r0A+0sF6/DvZHcyz6OqeQAAIbmuxi5m68gDSP3XzGZdLxTyiyaJoK9CcA=
=tFit
-----END PGP SIGNATURE-----

--PGNNI9BzQDUtgA2J--
