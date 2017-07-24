Received: from eggs.gnu.org ([2001:4830:134:3::10]:35643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dZdg3-0006IW-TF
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 09:45:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dZdg0-0000zu-Mk
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 09:45:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dZdg0-0000zM-Fg
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 09:45:36 -0400
Date: Mon, 24 Jul 2017 14:45:32 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170724134532.GF2784@stefanha-x1.localdomain>
References: <20170719100802.14094-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ls2Gy6y7jbHLe9Od"
Content-Disposition: inline
In-Reply-To: <20170719100802.14094-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 0/2 (for 2.10] Document deprecated
 features & support lifecycle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--Ls2Gy6y7jbHLe9Od
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2017 at 11:08:00AM +0100, Daniel P. Berrange wrote:
> This is a followup to
>=20
>   v1: https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg02390.html
>   v2: https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg01286.html
>   v3: https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg00651.html
>   v4: https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg04239.html
>=20
> I would really strongly like to see this documented in time for the
> 2.10 release, so that we can start the clock ticking on our deprecation
> policy and thus actually delete some stuff in the not too distant
> future.

I agree, 2.10 material:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Ls2Gy6y7jbHLe9Od
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZdfn8AAoJEJykq7OBq3PIDQgH/2jSTv1ygsNAo+hGrcEDSs2/
n8Oi5Bk8AQuJb9/Pf5KJSLnw4ms5xU6xRYUy3iCJPxvynG4WowgiIU4qgIsGWeGs
WGKhtY+vLmn/BU2rPFh/8PBNOYq32nGJpdwQXJ/Ypb5axTsAefy2fqOzBrpOb5AS
AE8SVsmB/+Kjg3X9aEZWc8izzXhEiiQKAskkI7HEu27drX4QexRX35SheHv8x+4U
28XVk5X5qS3jJYn1EMSIVhRwtEL2YYB/EKOllJC/mDrA7Y3a52vNiUlxPEi9xzSi
3oTefj9cTePIWIOhuVdE2f3lXgxoc84g2YMi3NrFBj9rV4tEXlvG/9La2TKSTX8=
=fv6R
-----END PGP SIGNATURE-----

--Ls2Gy6y7jbHLe9Od--
