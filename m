Received: from eggs.gnu.org ([2001:4830:134:3::10]:33435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fT5zI-0008UK-Qy
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fT5zF-00060Z-LM
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:39:00 -0400
Date: Wed, 13 Jun 2018 14:38:55 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180613133855.GN24528@stefanha-x1.localdomain>
References: <1528866321-23886-1-git-send-email-thuth@redhat.com>
	<1528866321-23886-4-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yK/6QRnH3Zanb0EF"
Content-Disposition: inline
In-Reply-To: <1528866321-23886-4-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] qemu-options: Improve the
 documentation of '-accel' and '-machine accel=...'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>, zhang.zhanghailiang@huawei.com, Markus Armbruster <armbru@redhat.com>, qemu-trivial@nongnu.org


--yK/6QRnH3Zanb0EF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2018 at 07:05:20AM +0200, Thomas Huth wrote:
> Instead of repeating the same text for both options, let's rather change
> the '-machine accel' documentation to point to the preferred '-accel' opt=
ion
> instead.
> And in the documenation of the -accel option, make it clear that you can
> use colons to specify multiple accelerators.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qemu-options.hx | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--yK/6QRnH3Zanb0EF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbIR5uAAoJEJykq7OBq3PICDkH/3hsoMwaLqVnLNd5wKeZZ5wh
S7/H/LUvhexLs7VMhOMCOX6Z8eEOonr36VXyw4dVscmqY5ufIam9hw88yk2uypma
5ETbex5gQPS/osSlq/9ph8/wlXlnSc2P7bUHHmg9PmF1n4r8rT7v7LgXULT76qqi
fNDCmoJtpnZxaVNabbzNTX4voqaWTWJQ/4FdMKzM2NUQbt7p5QYYanNJqSsIt0fL
dgl+VjHcrHWQt561SVG+vAB7Cz0iNoPTxauG2WOxAYzwlSW9za+GT6o3iu0XDxiL
6hQhAjHfYi6BKmtbsCHSd1hTfWr6/79mAt0xgah1VTHa5glywplunfkllVx0Uew=
=opkH
-----END PGP SIGNATURE-----

--yK/6QRnH3Zanb0EF--
