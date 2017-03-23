Received: from eggs.gnu.org ([2001:4830:134:3::10]:43595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cqyZs-0003Lu-2S
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 04:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cqyZp-000656-HL
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 04:58:38 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cqyZp-00064g-BN
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 04:58:37 -0400
Received: by mail-wm0-x243.google.com with SMTP id n11so15106120wma.0
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 01:58:34 -0700 (PDT)
Date: Thu, 23 Mar 2017 08:58:29 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170323085829.GM16717@stefanha-x1.localdomain>
References: <1490119729-26206-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6Mt39TZj+HFMr11E"
Content-Disposition: inline
In-Reply-To: <1490119729-26206-1-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] configure: Fix cut-n-paste errors in OS
 deprecation warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, patches@linaro.org


--6Mt39TZj+HFMr11E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 21, 2017 at 06:08:49PM +0000, Peter Maydell wrote:
> Fix some cut-and-paste errors in the OS deprecation warning
> pointed out by Thomas Huth.
>=20
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  configure | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6Mt39TZj+HFMr11E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY0441AAoJEJykq7OBq3PIlZIH/RhD0Zw/hztMXzozFCfpzJrP
ZO33BeIbJqSULWhMY+FSPk9jLsKZxU+avpMr5anNilUkdhA3vg311bjkkuEQ1TFI
jeLLfQi30yQBzx0inPsM5ZDLTnvvaW42bDLLH0ICniypnR4GKJB/HhNtVu63sU5L
H3zvkaOzU3jKEuJK26qUeG4or0qCmSdOEJ73CvYIr4bjYwAEyMxhz+NNh6Y8wwn0
GDp8EDZgB/Om+IW0oXqEEB3heOsvWnWpc9aq6xtjOIFXnnU+9pcAd+on73YVLwya
ovUXDAGR/mOZ+7jmV4lUf4MdRLWbyHW7gqXaGnEPA5u1zfg4hCdN7mjWjh/tZjU=
=H445
-----END PGP SIGNATURE-----

--6Mt39TZj+HFMr11E--
