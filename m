Received: from eggs.gnu.org ([2001:4830:134:3::10]:47056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e4pt1-0005os-5A
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 11:04:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e4psx-0003ur-BC
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 11:03:59 -0400
References: <1508336428-20511-1-git-send-email-thuth@redhat.com>
	<1508336428-20511-3-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <efcd4a44-2630-db7d-4b27-bb71fc6f4896@redhat.com>
Date: Wed, 18 Oct 2017 10:03:45 -0500
MIME-Version: 1.0
In-Reply-To: <1508336428-20511-3-git-send-email-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nxhSDtkI9SBAhhqpH8BDp2G3VGEEeGxWK"
Subject: Re: [Qemu-devel] [PATCH 2/2] tests: Enable the very simple virtio
 tests on s390x, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, Michael S Tsirkin <mst@redhat.com>, Amit Shah <amit@kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nxhSDtkI9SBAhhqpH8BDp2G3VGEEeGxWK
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com,
 Michael S Tsirkin <mst@redhat.com>, Amit Shah <amit@kernel.org>
Message-ID: <efcd4a44-2630-db7d-4b27-bb71fc6f4896@redhat.com>
Subject: Re: [PATCH 2/2] tests: Enable the very simple virtio tests on s390x,
 too
References: <1508336428-20511-1-git-send-email-thuth@redhat.com>
 <1508336428-20511-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1508336428-20511-3-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/18/2017 09:20 AM, Thomas Huth wrote:
> These tests can easily be used on s390x, too. We just have to make
> sure to use the virtio-xxx-ccw devices instead of virtio-xxx-pci.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--nxhSDtkI9SBAhhqpH8BDp2G3VGEEeGxWK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnnbVEACgkQp6FrSiUn
Q2q3RQf/e1OM88M3KBox6mGOK3+HbsZTwi82L5GlORl4naN0GWzHJBYVstTd0SBT
cFo+/5niE7TzD969UByapotqvkvJzl3ONk8Dw4o6UEarHp38rDyO+CFIeTjZAny8
UNX7curDOmHkWrRkZCtMz58Pr2atBmQeOQPoOeEu5L4aSrYvSTD/8igBfYWjkCIY
WfLTfCzs4QR2NdY8tA2+jPf1gN1d8s/42mVkLYvkGCmTXxdJo0fDjQWd6BYLc7gT
+PUjzAynm3PuaqyR7I0qSsY0kce53coZObq41XLMig+rq8TkPqCr2Arm8WyTlJLD
tlGj5+aDEwf3Q3di6ZQEw4+MgmUi2A==
=4ZBZ
-----END PGP SIGNATURE-----

--nxhSDtkI9SBAhhqpH8BDp2G3VGEEeGxWK--
