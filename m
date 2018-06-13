Received: from eggs.gnu.org ([2001:4830:134:3::10]:43568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fT6a8-0007sI-5C
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:17:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fT6a2-0005OO-JF
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:17:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51758 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fT6a2-0005NR-Ea
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:16:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1A54988843
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 14:16:58 +0000 (UTC)
Date: Wed, 13 Jun 2018 15:16:56 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180613141656.GU24528@stefanha-x1.localdomain>
References: <20180611180152.2681-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iBHcHRCIarfY7C0j"
Content-Disposition: inline
In-Reply-To: <20180611180152.2681-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Remove COPYING.PYTHON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>


--iBHcHRCIarfY7C0j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2018 at 03:01:52PM -0300, Eduardo Habkost wrote:
> The COPYING.PYTHON file was added when we added the compatibility
> argparse.py module, which was licensed under the Python Software
> Foundation License Version 2.
>=20
> Now the compatibility argparse.py module was removed, and we are
> not carrying any code under that license anymore.  Remove
> COPYING.PYTHON.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  COPYING.PYTHON | 270 -------------------------------------------------
>  1 file changed, 270 deletions(-)
>  delete mode 100644 COPYING.PYTHON

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--iBHcHRCIarfY7C0j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbISdYAAoJEJykq7OBq3PIPG8IAIT8oweYaZY1NGiMhF6BRM1U
MPgI8uHplUOz41POZZDEAphu9y3MCrVa+JiCws456uGrvBLuyKaIQNSayEBgh5O+
mUDBwHUSIQeN6ZEAKoRnUOYVh0/ooKcjjr/3QWkF9jLe1x0BKG9VnCkgL+mmbJs0
vXC9lF74mLw3P1ct5AUCSJnHUHF8nf8waDyDiH3RqRC2ODCS1NUzow7GwxUHkCI2
h/V01dy7Cjdvzn1nF3CWueVkuPHyLMIcc+XXh38uty0aa5uu0Katix9eIjlisGtb
XQHtR09uweeUeFSz7up6MlO+ZJ2Shy3UnCWypP4Ou9OkY0OCWyJ9u5h2TBVFh0s=
=gzSB
-----END PGP SIGNATURE-----

--iBHcHRCIarfY7C0j--
