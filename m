Received: from eggs.gnu.org ([2001:4830:134:3::10]:58489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1diHlQ-00066U-JO
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:10:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1diHlL-00081i-Kl
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:10:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1diHlL-00081W-E5
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:10:51 -0400
Date: Thu, 17 Aug 2017 11:10:44 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170817101044.GC5539@stefanha-x1.localdomain>
References: <20170817024746.5961-1-famz@redhat.com>
	<20170817024746.5961-3-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2JFBq9zoW8cOFH7v"
Content-Disposition: inline
In-Reply-To: <20170817024746.5961-3-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC v2 02/10] qemu.py: Add variable vga type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, pbonzini@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>


--2JFBq9zoW8cOFH7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2017 at 10:47:38AM +0800, Fam Zheng wrote:
> Some guests behave differently when no VGA is detected. Add a variable
> to allow override the "none" default.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  scripts/qemu.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--2JFBq9zoW8cOFH7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZlWukAAoJEJykq7OBq3PI5zsH/18u3U9rnEPuQYoEAS2ba5u3
9Obgrfzvl2EsJ1N34YTfkrWF+yJoUYqT/kIMtiYzLXl7cNZtoyLl2RN7OgEZFUoo
fESl3ShNNDgSvjY+5TJ72K2jgNZ8ZTrTbObvum7NDchPm1iXGMWES3hLXoidT84Q
Uk5dmiSiPQSFER2PrcKjFNFOu8/YHMEYZQy7JwnMbq5Tbm9hroj3iTqySH5OEDWH
B8Kgd6kk5TtUszPBnwzvNJz3ChLwPT04gH8HmHSZmpauZWhV9Gi+8hn5stF5H4St
pTJ6tNWlJbB+bARSI8HVk9pT4X2KaNL9ng1XBPakhAVch7PIQ13nrGVeI4gOhZE=
=qY+D
-----END PGP SIGNATURE-----

--2JFBq9zoW8cOFH7v--
