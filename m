Received: from eggs.gnu.org ([2001:4830:134:3::10]:55378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhwpg-0006oO-0A
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 07:49:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhwpb-0005gw-Hs
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 07:49:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dhwpb-0005gF-7k
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 07:49:51 -0400
References: <20170816072104.24420-1-famz@redhat.com>
	<20170816072104.24420-5-famz@redhat.com>
	<20170816085515.GB3180@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <32300907-eeaa-7c4c-b3f5-3631f0dbb2da@redhat.com>
Date: Wed, 16 Aug 2017 06:49:44 -0500
MIME-Version: 1.0
In-Reply-To: <20170816085515.GB3180@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8BB4QebjuCJ2q26nxVCFkB5cUo9n6Bl9F"
Subject: Re: [Qemu-devel] [PATCH RFC 4/9] tests: Add vm test lib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com, pbonzini@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8BB4QebjuCJ2q26nxVCFkB5cUo9n6Bl9F
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com,
 pbonzini@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <32300907-eeaa-7c4c-b3f5-3631f0dbb2da@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 4/9] tests: Add vm test lib
References: <20170816072104.24420-1-famz@redhat.com>
 <20170816072104.24420-5-famz@redhat.com>
 <20170816085515.GB3180@stefanha-x1.localdomain>
In-Reply-To: <20170816085515.GB3180@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/16/2017 03:55 AM, Stefan Hajnoczi wrote:

> I'm not aware of a QMP equivalent for "info usernet".  It may be
> necessary to implement a query-usernet command if you don't want to use=

> HMP.

It's possible to run any HMP command from within QMP, using
human-monitor-command.  Parsing the resulting string is the same as you
would get with pure HMP, though.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--8BB4QebjuCJ2q26nxVCFkB5cUo9n6Bl9F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmUMVgACgkQp6FrSiUn
Q2psuwf+LPmzCPDq25pfFNbWcIbmDtVOCgJI5Xh/Yt8Mdkc0q5P64+MQllGut/MB
KERVCEhFxFP+KE6ynAnuHPiHscnXrCNphckhZFn7oMCjTUnMFjMBCtejE2cjcYnS
cOz9pQensqx2Y9vCN+KAz8wZNsA4TPawctcnsldmKgSsTJt2rSSl1pZ3q65pLYbL
GIjFABNYyVI6WWCqNCzIzpzWV5Tvfe0wgduD9YzjLSEAJdABCiSFXSEi8XECDb6J
YvPedUkORwGUFBqm++A0d8QTUz5SsfTIX5Dn6NZFsf7dWI/yCePdwt/WkeMOVuAm
P7VW1OuWM9+Sdk+l0kOjRlHwx1th7Q==
=AMHy
-----END PGP SIGNATURE-----

--8BB4QebjuCJ2q26nxVCFkB5cUo9n6Bl9F--
