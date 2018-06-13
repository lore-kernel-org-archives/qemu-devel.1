Received: from eggs.gnu.org ([2001:4830:134:3::10]:60024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fT5rz-0004f3-D1
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fT5ru-0002eN-Pq
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:31:27 -0400
Date: Wed, 13 Jun 2018 14:31:19 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180613133119.GJ24528@stefanha-x1.localdomain>
References: <20180611141716.3813-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEkEgRdBLZYkpbX2"
Content-Disposition: inline
In-Reply-To: <20180611141716.3813-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2] CODING_STYLE: Define our preferred form
 for multiline comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, patches@linaro.org, Richard Henderson <rth@twiddle.net>, John Snow <jsnow@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Alex Williamson <alex.williamson@redhat.com>, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>


--PEkEgRdBLZYkpbX2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2018 at 03:17:16PM +0100, Peter Maydell wrote:
> The codebase has a bit of a mix of different multiline
> comment styles. State a preference for the Linux kernel
> style:
>     /*
>      * Star on the left for each line.
>      * Leading slash-star and trailing star-slash
>      * each go on a line of their own.
>      */
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This is not my personal favourite, but seemed to be the
> closest we had to consensus in the mail thread for v1;
> I can live with it in order to avoid getting patches which
> use the styles I like even less :-)
> ---
>  CODING_STYLE | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--PEkEgRdBLZYkpbX2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbIRynAAoJEJykq7OBq3PIgkgIAKBe3mYlriWgnIEYwKg6B9vy
vrp7oFz3YLD8bresoacaJpNfpUu+y0B3VoehPFIMaK2I3B7IhGJPaGvAp84g4VWp
bpRoCKx8prLQyJ8lyDu5pdsKNGRqGdd8PBhj3frg66KPGWKlgNA2lSTWPN5gbWVG
DrfCiPisJuCrd3HYpLdNLo5qwofSOX8wVRmkDC6RW/JAoYbueuYxlkq2Uc1tp4sR
Y997OthLHCBec4PrTj12P1RgEV0MgdeQhml0eUEiuF8/VqP5LZynnwquR0GbiN7t
idi/OhbrhGL1NaSMRs1yTDIxamfLhOPu/L8i+NO7Pco8ehV3pBQjFKfPo51VnB4=
=hDWu
-----END PGP SIGNATURE-----

--PEkEgRdBLZYkpbX2--
