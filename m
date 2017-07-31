Received: from eggs.gnu.org ([2001:4830:134:3::10]:35910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcEV1-0007i7-UB
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 13:29:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcEV0-0001s5-TH
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 13:28:59 -0400
References: <20170731162641.24160-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fbe60111-cd7b-a69f-fc69-a385cd192b3c@redhat.com>
Date: Mon, 31 Jul 2017 12:28:44 -0500
MIME-Version: 1.0
In-Reply-To: <20170731162641.24160-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lSurBPjaGWJn3IDQEVSk62iosGLHBkvvH"
Subject: Re: [Qemu-devel] [PATCH v3] qemu-iotests: add a "how to" to ./README
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, Ishani Chugh <chugh.ishani@research.iiit.ac.in>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lSurBPjaGWJn3IDQEVSk62iosGLHBkvvH
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Jeff Cody <jcody@redhat.com>, Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Message-ID: <fbe60111-cd7b-a69f-fc69-a385cd192b3c@redhat.com>
Subject: Re: [PATCH v3] qemu-iotests: add a "how to" to ./README
References: <20170731162641.24160-1-stefanha@redhat.com>
In-Reply-To: <20170731162641.24160-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/31/2017 11:26 AM, Stefan Hajnoczi wrote:
> There is not much getting started documentation for qemu-iotests.  This=

> patch explains how to create a new test and covers the overall testing
> approach.
>=20
> Cc: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---

>  Please send improvements to the test suite, general feedback or just
>  reports of failing tests cases to qemu-devel@nongnu.org with a CC:
>  to qemu-block@nongnu.org.
> +
>=20

Is this adding a spurious blank line at EOF?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lSurBPjaGWJn3IDQEVSk62iosGLHBkvvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll/aMwACgkQp6FrSiUn
Q2qpcQgAlo6wqv2WUkXJlBx1jBBfuEslJUWGtE/BjdyfB726zN/3OkOTKIweWCTq
md5SpiAp218hYwWFRFdQUwjBdcQEb0Tl6/dewqg+8mz0aON0YBp9DhFjKryu+S14
iyBytqwkOyFWY4J/p9eUr471TPOido2Uji/dwWTHUyXuKB/rzTeo+E4az4FHP2Ah
q1gj2LcwiTN/X7ZTbip1c15ky+BMnyQ8sirhptILBVEkT1U67jjtqSGDt4/X+ZQP
+fIlQG5fMcdjOHE94qkIsESuLjl1lBBonWDocWWCsQUYq54hWkeIWPL/f4jRamoX
VFoS95TV6TBeMu1B5FTlVWeuqH+c1w==
=hIEE
-----END PGP SIGNATURE-----

--lSurBPjaGWJn3IDQEVSk62iosGLHBkvvH--
