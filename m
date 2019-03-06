Received: from eggs.gnu.org ([209.51.188.92]:48413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1h1TIe-0006m0-UW
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:57:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1h1TIe-0003PA-3y
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:57:20 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1h1TId-0003OY-Sp
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:57:20 -0500
Received: by mail-wm1-x344.google.com with SMTP id n19so5257182wmi.1
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 01:57:19 -0800 (PST)
Date: Wed, 6 Mar 2019 09:57:17 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190306095717.GH22159@stefanha-x1.localdomain>
References: <20190301163518.20702-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JI+G0+mN8WmwPnOn"
Content-Disposition: inline
In-Reply-To: <20190301163518.20702-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: add missing support status
 fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, thuth@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>


--JI+G0+mN8WmwPnOn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2019 at 04:35:18PM +0000, Stefan Hajnoczi wrote:
> This patch adds the "S:" line for areas of the codebase that currently
> lack a support status field.
>=20
> Note that there are a few more areas that are more abstract and do not
> correspond to a specific set of files.  They have not been modified.
>=20
> Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--JI+G0+mN8WmwPnOn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcf5l9AAoJEJykq7OBq3PIC+wIALhYa/1EYF2WOSkMJg9AVDbP
HE2F2CP3p03rWZdcxYjs5S9z1ZW7DtjZekHAryuI6TltvfxvSEMpgWJhnq1PX+80
gJGgJ7//PR1LDiku4iJqrBf2Ag/jcIUT8WIQZrQDijq685ivzCTT5JxsKR2900BH
NbMsEJMM8aoh+I1TCOUJ1NiuaHVwqh1UbP66eYqKO1m20wmkrukITt6sW9dyHFzD
CpPYdjSH4czzCO/eGFi39wtWUPK8mpXlAeCGEvJhSxFMoaxwB3QTEIPycZaMyxBU
rwH2Hw8OPlBK+hQ0YvbE3nvmx5Qv4gvRPsCeQfixHqesVo8EHWXE2VZv+uKQCBw=
=CNsF
-----END PGP SIGNATURE-----

--JI+G0+mN8WmwPnOn--
