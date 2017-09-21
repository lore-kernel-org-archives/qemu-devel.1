Received: from eggs.gnu.org ([2001:4830:134:3::10]:34443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dv3KP-0002Tm-VW
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:23:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dv3KN-0001OK-9z
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:23:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dv3KN-0001O0-0U
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:23:47 -0400
References: <20170921150755.19914-1-famz@redhat.com>
	<20170921150755.19914-2-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <99df6023-be07-dac0-1434-105774c383ac@redhat.com>
Date: Thu, 21 Sep 2017 10:23:38 -0500
MIME-Version: 1.0
In-Reply-To: <20170921150755.19914-2-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8sR1Cai78lm49aphMllXI8GwUfgsC8Ujb"
Subject: Re: [Qemu-devel] [PATCH v11 01/13] gitignore: Ignore vm test images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8sR1Cai78lm49aphMllXI8GwUfgsC8Ujb
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>,
 stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com,
 Kamil Rytarowski <kamil@netbsd.org>
Message-ID: <99df6023-be07-dac0-1434-105774c383ac@redhat.com>
Subject: Re: [PATCH v11 01/13] gitignore: Ignore vm test images
References: <20170921150755.19914-1-famz@redhat.com>
 <20170921150755.19914-2-famz@redhat.com>
In-Reply-To: <20170921150755.19914-2-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/21/2017 10:07 AM, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  .gitignore       | 1 +
>  tests/.gitignore | 1 +
>  2 files changed, 2 insertions(+)

Missing my R-b from v10.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--8sR1Cai78lm49aphMllXI8GwUfgsC8Ujb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnD2XoACgkQp6FrSiUn
Q2or9Qf7BOi7Uwjbsef/OB7WhpMgBO6c6mp7w3dnq5e5HcEzjQEo5Wfu3IppurBW
OzHTqS6IdBWsfKBtCtom1pc+ccKjj+S2bvkLgvCO7jIc5y6a6hLfpfBbNaPlMZX1
m0vNy0J1e1dFYZ5NmO3KSK+h7FozbY7ORMQMopLMUCabkLAWsz3VGeyKbStIHPHP
Bc0DnHa80llfNHjcdXTj5FRxoerxwinaZRyi7VvR10C6+owIsOO9I3FW22Q9BxXv
8e+WQ1j3/XkXwklPKJ1bdShQRjs5AKAWTSGP32BUlMrRDj30czGFMtq7gMujLV1w
nnPTgTpEn/bTmZ/YdC6qYVPD+ey8zg==
=orw6
-----END PGP SIGNATURE-----

--8sR1Cai78lm49aphMllXI8GwUfgsC8Ujb--
