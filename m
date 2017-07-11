Received: from eggs.gnu.org ([2001:4830:134:3::10]:46098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUrbi-0007Xh-EH
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:37:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUrbf-0001YA-DM
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:37:26 -0400
Date: Tue, 11 Jul 2017 10:36:19 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170711093619.GH17792@stefanha-x1.localdomain>
References: <20170707154646.22230-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qM81t570OJUP5TU/"
Content-Disposition: inline
In-Reply-To: <20170707154646.22230-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hxtool: remove dead -q option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, marcandre.lureau@redhat.com


--qM81t570OJUP5TU/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 07, 2017 at 05:46:46PM +0200, Paolo Bonzini wrote:
> This was used to extract .txt documentation for QMP.  This was
> changed to use the QAPI schema instead, so zap it.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/hxtool | 46 +---------------------------------------------
>  1 file changed, 1 insertion(+), 45 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--qM81t570OJUP5TU/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZJwTAAoJEJykq7OBq3PIi84H/jP4dQFSbbttSBbvP8lDJNFH
ALi2h5DotiLrVw/VgqY8cv9dLzQhw71d05O0NOCLOlepURPoPhWf5IVUU8cjidRu
opuS33lQ0qEAQbs1ZnzDE37l+HpQfUwrFTgtMOC3zXe7imlCuTMPiyo+AnVI4KLX
AJqgH1/Fxb2PBEobDEOBCSH9is4ZYuNmQk5Ex47rRRY0ZOSxm6xZJKCkyUbS0fZK
dhLlfpoS6uX/eEau3XAto8wB0+6CiV1RiZG0OBaKuODgxAJ/3d9vhX49h33LniJy
Xy+XPZB+fTJjyj63lmOCbrQo8EzKg9OkGxy1s0WBRVwTHb5H9DRJ3Lpdbw0kyEQ=
=iQtW
-----END PGP SIGNATURE-----

--qM81t570OJUP5TU/--
