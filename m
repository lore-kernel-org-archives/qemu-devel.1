Received: from eggs.gnu.org ([2001:4830:134:3::10]:33388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eoBDn-0006WK-23
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 11:56:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eoBDj-00047z-90
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 11:56:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52850 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eoBDj-00047V-41
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 11:56:47 -0500
Date: Tue, 20 Feb 2018 16:56:34 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180220165634.GA12161@stefanha-x1.localdomain>
References: <12c223afbafb402d6e6602a5888e5dca2953dbfc.1519044214.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <12c223afbafb402d6e6602a5888e5dca2953dbfc.1519044214.git.tgolembi@redhat.com>
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH] docs: document virtio-balloon
 stats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, Wei Wang <wei.w.wang@intel.com>, Jonathan Helman <jonathan.helman@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2018 at 01:43:44PM +0100, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD=
 wrote:
> Document statistics added in commits
>=20
>     commit a0d06486b445985b8d128df172daefbae205bffd
>     Author: Denis V. Lunev <den@openvz.org>
>     Date:   Wed Feb 24 10:50:48 2016 +0300
>=20
>         virtio-balloon: add 'available' counter
>=20
> and
>=20
>     commit bf1e7140ef0b3a149860ab9f05b36665133238f6
>     Author: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
>     Date:   Tue Dec 5 13:14:46 2017 +0100
>=20
>         virtio-balloon: include statistics of disk/file caches
>=20
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> ---
>  docs/virtio-balloon-stats.txt | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJajFNBAAoJEJykq7OBq3PIYmoIAJCqyVBCOddyRe7A+xIDRaoh
enFTqfHEJ82tLaq4Tebw/aONy2UdklNg43kdVjUFHOmk4aELRq1psQhOmPvSq/Wb
/2v/KuySJaigGGrbjzeQ0YjJcqWLdgTXvoBvEyCP999/3FHx6vJvH4zlVcc68i8g
BU+RfjZMGqjs1l9WcMwkco4bNmVhL6AohBozJK6TPyN2gn/UZwPnneqdOP0ysL2W
uTzo4uqekm4n9wZhmT4WlkhIcA7g54G7vkHkBScbM/QhiFRSj2Bq7olBjygQqfZW
nv8x6LCOaK5ZRD5CfyIH3iSYvMLCPbwryteYQAIfwf43rxWvN4C8Sa8vSFycxfM=
=cmwu
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
