Received: from eggs.gnu.org ([208.118.235.92]:52111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehM1E-0004Na-SB
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 16:04:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehM0A-00019O-Sf
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 16:03:40 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<9f551b36d688079dcda4838c788f41a190b5219c.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4720ac9c-b259-ebca-f9a7-2bd0b73c6193@redhat.com>
Date: Thu, 1 Feb 2018 21:12:54 +0100
MIME-Version: 1.0
In-Reply-To: <9f551b36d688079dcda4838c788f41a190b5219c.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="yCkf1jnv5BJae7eJItP4eeCfzdmCVoOmi"
Subject: Re: [Qemu-devel] [PATCH v3 39/39] iotests: Add l2-cache-entry-size
 to iotest 137
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yCkf1jnv5BJae7eJItP4eeCfzdmCVoOmi
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <4720ac9c-b259-ebca-f9a7-2bd0b73c6193@redhat.com>
Subject: Re: [PATCH v3 39/39] iotests: Add l2-cache-entry-size to iotest 137
References: <cover.1516978645.git.berto@igalia.com>
 <9f551b36d688079dcda4838c788f41a190b5219c.1516978645.git.berto@igalia.com>
In-Reply-To: <9f551b36d688079dcda4838c788f41a190b5219c.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 16:00, Alberto Garcia wrote:
> This test tries reopening a qcow2 image with valid and invalid
> options. This patch adds l2-cache-entry-size to the set.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  tests/qemu-iotests/137     | 5 +++++
>  tests/qemu-iotests/137.out | 2 ++
>  2 files changed, 7 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--yCkf1jnv5BJae7eJItP4eeCfzdmCVoOmi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpzdMYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Au2MIAIh9ZkoChT6IfodJGgyFs2T6zkPgz2tg
GOE/Gs3bONpUWNkyjsFtXX9xj8LcKZVaxtspw2E57DXKpuqpJPiRZQVnhy+iCeW9
DFOSe0XfXxp+NDPtsvwJcAM8RIVwm2bwK2YV1lGQcBzLmpGfTjdf01qDntMTFnNI
D9NT97flYzSl7qm5Doa5ok3SBJuVD23T86RgZ03mVZeW6LkaVvWltSL6JtBdVxnv
ECTxO9jCWOuVru8s+NI/xL2PW+1bkmPzEfyTDQjevhNFBSwYZepd0SLc+B4r4T8x
sjYUPzNHwLjt/OUmGmBnGl+u7qMqPQxLLPf/w0VpTUeVjTWNYWuKeRM=
=o3CE
-----END PGP SIGNATURE-----

--yCkf1jnv5BJae7eJItP4eeCfzdmCVoOmi--
