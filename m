Received: from eggs.gnu.org ([209.51.188.92]:55784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gr2T9-0002wg-2r
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 10:17:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gr2T6-0006LW-LI
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 10:17:01 -0500
References: <1549378185-7970-1-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7d8e1cf1-77ca-2fa6-face-c164708cb078@redhat.com>
Date: Tue, 5 Feb 2019 09:10:33 -0600
MIME-Version: 1.0
In-Reply-To: <1549378185-7970-1-git-send-email-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="b2VWQlOQ85Ar4URTeWFS25C0VRJ3xIKwe"
Subject: Re: [Qemu-devel] [PATCH] tests/qemu-iotests: Remove redundant
 COPYING file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b2VWQlOQ85Ar4URTeWFS25C0VRJ3xIKwe
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org
Message-ID: <7d8e1cf1-77ca-2fa6-face-c164708cb078@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tests/qemu-iotests: Remove redundant COPYING
 file
References: <1549378185-7970-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1549378185-7970-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/5/19 8:49 AM, Thomas Huth wrote:
> The file tests/qemu-iotests/COPYING is the same text as in the
> COPYING file in the main directory. So as far as I can see, we don't
> need the duplicate here.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qemu-iotests/COPYING | 339 -------------------------------------=
--------
>  1 file changed, 339 deletions(-)
>  delete mode 100644 tests/qemu-iotests/COPYING

qemu-iotests started life as a separate project, and was bulk-imported
into qemu in commit 6bf19c94.  This is indeed leftovers from the
pre-merge state.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--b2VWQlOQ85Ar4URTeWFS25C0VRJ3xIKwe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxZp2kACgkQp6FrSiUn
Q2oNfAgAihsjG7bjc3K2DBQLOuizJRoUD5rizJBGm9U3fl1XTYbJuDA0JbsMXErJ
p1Oi4ChP99vRlHUL4lf6s/5S2e1irCyk1aXYCDeqQcP1Plfy4ytyDrP5ae3Nr20b
tDCfbeOkkvSPXazwJ2dUNWziytYEyVDNxiFvms1vkVQkbH8aau5VUsv2ZZkAkwTp
uxWV2qQcPpa8FvgpGJK89eBO6XgpLD1MDAy7rHZsUpe34D3TRjdaKwEgDJrOao41
PuAJESmQnbEranl98v390Zw3mIGiQLfxMa4ltfKgA2YnfAvwrLO1yUX1YrT4NqZf
waX6z98z27SBEbpGJ3qwtV//bLeAqw==
=/HHL
-----END PGP SIGNATURE-----

--b2VWQlOQ85Ar4URTeWFS25C0VRJ3xIKwe--
