Received: from eggs.gnu.org ([2001:4830:134:3::10]:34304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYdZO-0001Mi-PX
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:54:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYdZJ-0004YC-Vv
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:54:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cYdZJ-0004Y6-Pl
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:54:17 -0500
References: <1485888144-16531-1-git-send-email-mst@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bdc33d1a-7003-c3da-9934-53695f595c02@redhat.com>
Date: Tue, 31 Jan 2017 12:54:13 -0600
MIME-Version: 1.0
In-Reply-To: <1485888144-16531-1-git-send-email-mst@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dtLLfjIxclgrfanlri0rUogCCPGaUp879"
Subject: Re: [Qemu-devel] [PULL v4 00/23] virtio, vhost, pci: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dtLLfjIxclgrfanlri0rUogCCPGaUp879
From: Eric Blake <eblake@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <bdc33d1a-7003-c3da-9934-53695f595c02@redhat.com>
Subject: Re: [Qemu-devel] [PULL v4 00/23] virtio, vhost, pci: fixes, features
References: <1485888144-16531-1-git-send-email-mst@redhat.com>
In-Reply-To: <1485888144-16531-1-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2017 12:42 PM, Michael S. Tsirkin wrote:
> The following changes since commit a0def594286d9110a6035e02eef558cf3cf5=
d847:
>=20
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into=
 staging (2017-01-30 10:23:20 +0000)
>=20
> are available in the git repository at:
>=20
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>=20
> for you to fetch changes up to 08e53904f541e987e264e522b573920755c5a939=
:
>=20
>   arm: add trailing ; after MISMATCH_CHECK (2017-01-31 16:50:42 +0200)

The commit message for 6/23 got corrupted, does this mean we need a v5
pull request?


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--dtLLfjIxclgrfanlri0rUogCCPGaUp879
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYkN1VAAoJEKeha0olJ0NqdCwH/AtIqvDnimdGH6owucQFE+Rn
GM8pXEGw09Rx9EFwIW+8ihADvCYmrpyCNwUeDj11yHusj0l/mzfEc+szndms2PVN
f31Kju05bifpx2IU1p7rSNCGnsMxEyxgpxBx0ETKWdntVAtc/rqWyuOQ0pU+JX93
BhQHNBFir0cf7yjB+eswQr23J3ibNHKFReZA+J1QFQ/cFNP/TWBdFXTYynUvvKMQ
edeRTnHhH5PiXkp+nvxjutXaxStM3Xf5P+sBBhZ2ylKysYWmapOlcSZJDYTNL+xv
b3tm6EacBIHg3VWCLhzPNsGGs+ZT2FQb6bCYuiNduaRN4QMGvCSMj+C1i72Vl4U=
=NtBQ
-----END PGP SIGNATURE-----

--dtLLfjIxclgrfanlri0rUogCCPGaUp879--
