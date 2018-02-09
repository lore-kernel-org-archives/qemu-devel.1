Received: from eggs.gnu.org ([2001:4830:134:3::10]:44735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ek8rX-0001jq-Ei
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 08:37:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ek8rT-0002DW-0C
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 08:37:11 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-3-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d8530726-8177-c63d-ffb5-6b4e86068412@redhat.com>
Date: Fri, 9 Feb 2018 14:36:57 +0100
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-3-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eDVozDC7nFHcRekX4PglQI50O1ilyqZkv"
Subject: Re: [Qemu-devel] [PATCH 02/27] block/qapi: Add qcow2 create options
 to schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eDVozDC7nFHcRekX4PglQI50O1ilyqZkv
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <d8530726-8177-c63d-ffb5-6b4e86068412@redhat.com>
Subject: Re: [PATCH 02/27] block/qapi: Add qcow2 create options to schema
References: <20180208192328.16550-1-kwolf@redhat.com>
 <20180208192328.16550-3-kwolf@redhat.com>
In-Reply-To: <20180208192328.16550-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-08 20:23, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json | 45 ++++++++++++++++++++++++++++++++++++++++++++=
-
>  1 file changed, 44 insertions(+), 1 deletion(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--eDVozDC7nFHcRekX4PglQI50O1ilyqZkv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp9o/kSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AH34H/jz3kwPO4zRe9HqtrXnvi0QadRaqryUO
uBipyMEK0GqbOZKEfewnnnH6UNQ10BmSHSCODpVA9tH6DybQdCOLaTWNBJT9RC1b
w3tAJaX9Dgd8jfi7Pl6Zpgcv+ejPBKRt8q5iZLTwZUYxB5UBBMJFduI9gskhAtUM
8FX6vjeqv/fV8DTcHaqLGev9TOQrMA3vOt5ZouWLFK8ocaJL6dCGH5fQOg3arw9X
UTM7pb90yK3np8iINQJTjz/lcpeSK5fURi3TkiKYpsUsLyXXAaJsWstP2OyFofyq
R1KfLGi8MoA9vUJOkQzVe8kVajGPxXFb0Dkdum0EVtsG0+621be0po4=
=iLhv
-----END PGP SIGNATURE-----

--eDVozDC7nFHcRekX4PglQI50O1ilyqZkv--
