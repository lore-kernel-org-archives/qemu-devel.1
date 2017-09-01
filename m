Received: from eggs.gnu.org ([2001:4830:134:3::10]:58812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnuFt-0004lk-0k
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 18:17:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnuFp-0002hQ-Sz
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 18:17:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dnuFp-0002g8-JB
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 18:17:33 -0400
References: <20170901105023.11108-1-kraxel@redhat.com>
	<CAKmqyKMUVEb13Ffv5YsovOTRAaQ8g=Q2C=U4FzWWZuygAdMwdA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2c31126f-81fb-7cd2-9575-8071e3623ab9@redhat.com>
Date: Fri, 1 Sep 2017 17:17:28 -0500
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMUVEb13Ffv5YsovOTRAaQ8g=Q2C=U4FzWWZuygAdMwdA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="u2eiopMmeq465rNV5DE1mhFMprfWv3v5S"
Subject: Re: [Qemu-devel] [PATCH] pixman: drop submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u2eiopMmeq465rNV5DE1mhFMprfWv3v5S
From: Eric Blake <eblake@redhat.com>
To: Alistair Francis <alistair23@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Message-ID: <2c31126f-81fb-7cd2-9575-8071e3623ab9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] pixman: drop submodule
References: <20170901105023.11108-1-kraxel@redhat.com>
 <CAKmqyKMUVEb13Ffv5YsovOTRAaQ8g=Q2C=U4FzWWZuygAdMwdA@mail.gmail.com>
In-Reply-To: <CAKmqyKMUVEb13Ffv5YsovOTRAaQ8g=Q2C=U4FzWWZuygAdMwdA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/01/2017 05:13 PM, Alistair Francis wrote:
> 'On Fri, Sep 1, 2017 at 3:50 AM, Gerd Hoffmann <kraxel@redhat.com> wrot=
e:
>> Drop pixman submodule and support for the "internal" pixman build.
>> pixman should be reasonable well established meanwhile that we don't
>=20
>=20
> Is there any use case for '--with-system-pixman now?
>=20
> Overall I think this is fine, Pixman does seem to be pretty common. I
> verified that RHEL7 has a new enough version, not sure about RHEL6
> though.

pixman-devel-0.32.8-1.el6.x86_64

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--u2eiopMmeq465rNV5DE1mhFMprfWv3v5S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmp3HgACgkQp6FrSiUn
Q2p2aAf/YZoUBcjBewbUIZqYDrWevGwv9hoo9IZA5dMsQLf3OtHG7qBK3paSTHrb
22DLZni76shq8m+jrrSz8B1rqS9k9O0krMxaz+XZfDcRY5+peLLB5LA8lmZs6ESR
AlGAiUN0lafp8KWAa9Yvsr5gtk7mNbwVERCw/XaOAWYFYWDpDtqb4MO7Y9tBmDqS
OcyTY8AbgrDJGoD1gqetEYUDO61ZW6OStRHGEavobpD5AEJ8SY3pbBW3jBvrkMlL
+6Zlfpb5eQNx+jKyyKUmmgVkD6eABIillDtGcul/vZME88DBKN1VK3izxShZ4rXo
/g0ij9kf6+iZ60obME7fhU+Xk0VZMQ==
=u5cy
-----END PGP SIGNATURE-----

--u2eiopMmeq465rNV5DE1mhFMprfWv3v5S--
