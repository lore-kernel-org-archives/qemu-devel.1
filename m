Received: from eggs.gnu.org ([2001:4830:134:3::10]:34008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eb5Mo-000261-Vd
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:04:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eb5Ml-0003Ze-On
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:04:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eb5Ml-0003ZL-IA
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:03:59 -0500
Date: Mon, 15 Jan 2018 14:03:52 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180115140352.GI13238@stefanha-x1.localdomain>
References: <20180110202553.31889-1-stefanha@redhat.com>
	<cb5cf329-50b6-845b-ff74-cd0001778611@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e5GLnnZ8mDMEwH4V"
Content-Disposition: inline
In-Reply-To: <cb5cf329-50b6-845b-ff74-cd0001778611@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] tracetool: improve error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>


--e5GLnnZ8mDMEwH4V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2018 at 02:48:16PM -0600, Eric Blake wrote:
> On 01/10/2018 02:25 PM, Stefan Hajnoczi wrote:
> > This series improves the tracetool error messages to make them more
> > user-friendly.
> >=20
> > Stefan Hajnoczi (3):
> >   tracetool: prefix parse errors with line numbers
> >   tracetool: clarify that "formats" means "format strings"
> >   tracetool: report error on foo() instead of foo(void)
>=20
> Series:
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> but see nit on patch 1

Thanks, will fix!

--e5GLnnZ8mDMEwH4V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaXLTIAAoJEJykq7OBq3PII40H+wSnel23YPY+Zlg2yBgVmkTN
1VYYiFwPg+e9Cz1nkWtmQmqRbkg2So7aPjlRSJ3QLEd5oBgNBa/HzZEcCwd/VF1K
Vs1FojmC1jmFJ72IZO2WbTmyOOeIPDepEufgv+2EiWglgXkyQcXKTM3Jtk5m82ct
sz8x3EoL8tfvWANVOVMoN2m9fOSZF+VJCDI5ODKcX+TGRC60yNRF3aGmiN9FmDjR
1SGC7nNYLCiLLqaL8yd8TpQ06e0wdKjznMi8BNGHXfMFvthN18+G1/HfxH/8Jn8W
FOs65uRyV9j5PuuD7QZI3l1ckrCFch/vj7Hxma+fnNy6Kn5O1R93VRmdiV1pujQ=
=63OH
-----END PGP SIGNATURE-----

--e5GLnnZ8mDMEwH4V--
