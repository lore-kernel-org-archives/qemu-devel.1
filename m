Received: from eggs.gnu.org ([2001:4830:134:3::10]:58739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1diHmf-0007A8-2i
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:12:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1diHme-0000T3-6X
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:12:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1diHme-0000QT-05
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:12:12 -0400
Date: Thu, 17 Aug 2017 11:12:02 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170817101202.GD5539@stefanha-x1.localdomain>
References: <20170817024746.5961-1-famz@redhat.com>
	<20170817024746.5961-4-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1sNVjLsmu1MXqwQ/"
Content-Disposition: inline
In-Reply-To: <20170817024746.5961-4-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC v2 03/10] qemu.py: Add "wait()" method
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


--1sNVjLsmu1MXqwQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 17, 2017 at 10:47:39AM +0800, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  scripts/qemu.py | 7 +++++++
>  1 file changed, 7 insertions(+)

It would be nice to unify this with shutdown() but it's okay for now.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--1sNVjLsmu1MXqwQ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZlWvyAAoJEJykq7OBq3PIWMUH/jjuy9uld18PCNhoyJBbINA2
1SD0yxSrEAreJ0IDKeS/HpFXYvYzIwVHuUd7tsFIl3cSjZch3mI5yGm+sdAv13nn
HiVaEzGHTCUjN7ly3d7nRejxzdMWgk5z+jfVdIx/VrfDzaXxyoqjBK5duC3h4eiZ
eRZVJ9IF0gNKXV9BZpXiWxn6bCZPUBVrIoccti9prV4wcpn0EjNB8pXDAEIpLVox
UHH20Q+X96SLVNafa3+LgRuVC2p+V8oargn7ce7GFVuJAsGM8rytxMn5clTPVOqu
W059l2DlXGs0RxvF4Sm7mS0VpdNKCwdbLha2KSzeSuS25GKdMRQXq8vbAOZthYs=
=eo6s
-----END PGP SIGNATURE-----

--1sNVjLsmu1MXqwQ/--
