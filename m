Received: from eggs.gnu.org ([209.51.188.92]:53750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grUPE-00063j-Ei
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 16:06:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grUPD-00007o-Rf
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 16:06:52 -0500
References: <20190206195551.28893-1-mreitz@redhat.com>
	<20190206195551.28893-7-mreitz@redhat.com>
	<4db6ac46-6dfd-64fc-a5f0-4e3d2a5802ab@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cf9ae9ef-8af7-094c-9f83-ff0bbec23cda@redhat.com>
Date: Wed, 6 Feb 2019 15:06:45 -0600
MIME-Version: 1.0
In-Reply-To: <4db6ac46-6dfd-64fc-a5f0-4e3d2a5802ab@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ENcVn1GPsWLeGehkjnKS6AkYAsald3QZ4"
Subject: Re: [Qemu-devel] [PATCH v3 6/8] block: Try to create well typed
 json:{} filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ENcVn1GPsWLeGehkjnKS6AkYAsald3QZ4
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Message-ID: <cf9ae9ef-8af7-094c-9f83-ff0bbec23cda@redhat.com>
Subject: Re: [PATCH v3 6/8] block: Try to create well typed json:{} filenames
References: <20190206195551.28893-1-mreitz@redhat.com>
 <20190206195551.28893-7-mreitz@redhat.com>
 <4db6ac46-6dfd-64fc-a5f0-4e3d2a5802ab@redhat.com>
In-Reply-To: <4db6ac46-6dfd-64fc-a5f0-4e3d2a5802ab@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/6/19 2:43 PM, Eric Blake wrote:
> On 2/6/19 1:55 PM, Max Reitz wrote:
>=20
> In the subject, s/well typed/well-typed/
>=20
>> By applying a health mix of qdict_flatten(), qdict_crumple(),
>=20
> s/health/healty/

typo in my typo fix for healthy :)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--ENcVn1GPsWLeGehkjnKS6AkYAsald3QZ4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxbTGUACgkQp6FrSiUn
Q2pVQQgAqP70lWfJywK90e3bNC1wIDYCSCPaAHDvNaO9OUN98Tt/g+ZZvyhnT1dk
M53uE9SN8EBuptWHZXTm1YdHiIuuEnNYJJcEfcwL2Ucmm6A6/LqnP+glpOojozUn
O8VyJ6/k6AvhUQYWuEARisdr6WJ8m5408vRXuPSTR4Nh+L7DxANN3/e1Ig0XGxcx
/D5jtG7ncbOzlCvNqJivzGeORYFHyy+Xjg9TB66j9hI7seD+3M+CR2gNsdeug3sY
ktzGBhOTk91XgKxuSOUjcnV/J2X1hmJeGv6JrtDpvQ9CYuQYGLyrzqcZ/BeQzFjB
uw75uO7XyDehctqmwgjEeGiEmKNYjw==
=pA/9
-----END PGP SIGNATURE-----

--ENcVn1GPsWLeGehkjnKS6AkYAsald3QZ4--
