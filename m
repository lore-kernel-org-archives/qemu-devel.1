Received: from eggs.gnu.org ([2001:4830:134:3::10]:44533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZeM5-0008Lp-Sr
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:29:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZeM4-0003Qf-TU
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:29:05 -0400
References: <20170721093416.17816-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5c16cc8e-884c-6e2b-ad60-b72ef6c59337@redhat.com>
Date: Mon, 24 Jul 2017 09:28:53 -0500
MIME-Version: 1.0
In-Reply-To: <20170721093416.17816-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="injkjEOtIlCrmLFF2j5LxS9ifE12aoOmr"
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: add a "how to" to ./README
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Ishani Chugh <chugh.ishani@research.iiit.ac.in>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--injkjEOtIlCrmLFF2j5LxS9ifE12aoOmr
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 Ishani Chugh <chugh.ishani@research.iiit.ac.in>, qemu-block@nongnu.org
Message-ID: <5c16cc8e-884c-6e2b-ad60-b72ef6c59337@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: add a "how to" to ./README
References: <20170721093416.17816-1-stefanha@redhat.com>
In-Reply-To: <20170721093416.17816-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/21/2017 04:34 AM, Stefan Hajnoczi wrote:
> There is not much getting started documentation for qemu-iotests.  This=

> patch explains how to create a new test and covers the overall testing
> approach.
>=20
> +2. Create the test file
> +
> +Copy an existing test (one that most closely resembles what you wish t=
o test)
> +to the new test number:
> +
> +  cp 001 <test-number>

And mark it executable (chmod a+x <test-number>)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--injkjEOtIlCrmLFF2j5LxS9ifE12aoOmr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll2BCUACgkQp6FrSiUn
Q2qp6gf+NsEUMPJZGbvRYyIb6+nmW5aAds17YhxtCVN6S6R/m06S/4dn5ZU3eVtI
kgkAkeZh0BxgbP7mRT08qpD9XT9lUvwdfe3jDS922TTysYv7vXihXaGU1XB8IMk6
1O+CpU2CbLXSLEQUkMN/St8dQfaCYqBdQcuxn+5dxofA+UpBXQ14BhO/cmKKKn91
b032QQ/9DlQx4lm9x40Az8kwsl/YAZFL0QBu012RLY1s702sSSvAOa2u+IvthOQs
6lCcrlyIEPfiBJ4rIakVAfV5+Kp5cn4920xSNkGeo5P4SksareW33WzsW0mSSHQy
8XtPvok/tGUpZ1/EGh+dRCJ5rpOI9Q==
=7pra
-----END PGP SIGNATURE-----

--injkjEOtIlCrmLFF2j5LxS9ifE12aoOmr--
