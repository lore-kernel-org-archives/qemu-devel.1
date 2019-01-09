Received: from eggs.gnu.org ([209.51.188.92]:42080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghF0l-0005G0-Po
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:39:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghF0k-0007aj-LZ
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:39:15 -0500
References: <1540876720-9574-1-git-send-email-liq3ea@gmail.com>
	<1540876720-9574-2-git-send-email-liq3ea@gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3037489d-1cfc-7a2c-758b-c329b14aa394@redhat.com>
Date: Wed, 9 Jan 2019 15:39:05 +0100
MIME-Version: 1.0
In-Reply-To: <1540876720-9574-2-git-send-email-liq3ea@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hdnHJlNrQMqO7Z3VKTYElctwBXyfB5WxH"
Subject: Re: [Qemu-devel] [PATCH 1/4] nvme: use TYPE_NVME instead of
 constant string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, keith.busch@intel.com, kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hdnHJlNrQMqO7Z3VKTYElctwBXyfB5WxH
From: Max Reitz <mreitz@redhat.com>
To: Li Qiang <liq3ea@gmail.com>, keith.busch@intel.com, kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <3037489d-1cfc-7a2c-758b-c329b14aa394@redhat.com>
Subject: Re: [PATCH 1/4] nvme: use TYPE_NVME instead of constant string
References: <1540876720-9574-1-git-send-email-liq3ea@gmail.com>
 <1540876720-9574-2-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1540876720-9574-2-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.10.18 06:18, Li Qiang wrote:
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  hw/block/nvme.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--hdnHJlNrQMqO7Z3VKTYElctwBXyfB5WxH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw2B4kACgkQ9AfbAGHV
z0AiEgf+NBsD1HG0Xazkh1cP9SYWwpMqdIMVkBpFVIE2DOfvJEkNpp1ZIrSRIHqy
nV6rK3yqyBZsIyrn6slKaOR8R6LiIW8ZKYBdokBXFUS44djyCq69qjrmF+n3MDFM
W73JocQUkK7AqU8U36oE7KSFqoz5IfwUXSL+dVzuVfNa2zy+x6ZPR3yaSfgDvXHC
jUnGcsF5akOK7Nyk8crHKQVS5CdOhdzX/OZxmc3feIwmnUaEgCweEGOOkkxjOuOV
qezgENQAFkGAL3pH4NaR9ReCi70SDmBXWDrOi9rYBkQPXLueVhsOpBh0vj4g94n8
ZEIlHC0UX+B3iokPlq6LNb66T9G9/A==
=g86V
-----END PGP SIGNATURE-----

--hdnHJlNrQMqO7Z3VKTYElctwBXyfB5WxH--
