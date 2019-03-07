Received: from eggs.gnu.org ([209.51.188.92]:53115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1h1qXC-0000IB-5O
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:45:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1h1qXB-0000ar-Fc
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:45:54 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45973)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1h1qXB-0000aL-53
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:45:53 -0500
Received: by mail-wr1-x441.google.com with SMTP id w17so16822681wrn.12
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 02:45:53 -0800 (PST)
Date: Thu, 7 Mar 2019 10:45:50 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190307104550.GE2843@stefanha-x1.localdomain>
References: <20190307072025.8041-1-elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9l24NVCWtSuIVIod"
Content-Disposition: inline
In-Reply-To: <20190307072025.8041-1-elena.ufimtseva@oracle.com>
Subject: Re: [Qemu-devel] [multiprocess RFC PATCH 00/37] Initial support of
 multi-process qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: elena.ufimtseva@oracle.com
Cc: qemu-devel@nongnu.org, john.g.johnson@oracle.com, sstabellini@kernel.org, jag.raman@oracle.com, konrad.wilk@oracle.com, ross.lagerwall@citrix.com, liran.alon@oracle.com, stefanha@redhat.com, kanth.ghatraju@oracle.com


--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2019 at 11:20:25PM -0800, elena.ufimtseva@oracle.com wrote:
> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>=20
> Initial support of multi-process qemu

Hi Elena,
Please use the following setting when sending future patch series:

  $ git config sendemail.thread shallow

This way all patches are part of a single email thread (starting with
your PATCH 00 cover letter).  Reviewers find this more convenient so
that individual emails don't get separated and lost.

Thanks,
Stefan

--9l24NVCWtSuIVIod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcgPZeAAoJEJykq7OBq3PIsIoH/iE+ZFC/S07WGL9w6fduqjkD
2D3X1ggBX284NPezbFPnIgAbeztrA1h3JqdBv9urTkKKiWzknLv9cV85hOcExGHN
IdanEHxgenJ2/fJ7l8zNegaKNgLKSM5lygJznHmCsGePeBJilV8K1DOjXUiwdIij
N2XmEf9eOxnV86O5yxde89s4MytiZn/5iPkbVWLMzCjf5vBSIU9KlnESXkZqt5yX
ZTxgkKSjYPFE7oA/PGDFzEciulZveta3slEy+rayFHf6rZtM/NSd0OusOdBKHh1M
osJHgMIovf5UWOG+QhHB+sbMWWwNClWU6YrYvEPH1QpQ0loVPAk7FV1d7mYw/Zw=
=mtFD
-----END PGP SIGNATURE-----

--9l24NVCWtSuIVIod--
