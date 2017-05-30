Received: from eggs.gnu.org ([2001:4830:134:3::10]:47825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFhlm-0002Fu-P7
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:05:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFhll-0000nf-Ri
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:05:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dFhll-0000mL-K2
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:05:09 -0400
References: <20170526054013.299-1-n54@gmx.com>
	<20170530062022.5841-1-n54@gmx.com>
	<58d04e43-1caa-f623-44fe-749dd351fad9@redhat.com>
	<42633e66-7ef4-c4ef-18d3-d2be588b816c@gmx.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6ee03c9d-3c42-4f73-1ca9-313f50be63df@redhat.com>
Date: Tue, 30 May 2017 09:05:05 -0500
MIME-Version: 1.0
In-Reply-To: <42633e66-7ef4-c4ef-18d3-d2be588b816c@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DQiLaV9xIG6A9V0Avf76DIon8E68ePkoj"
Subject: Re: [Qemu-devel] [PATCH] ivshmem-server: ivshmem-client: Build when
 eventfd() is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, marcandre.lureau@gmail.com, armbru@redhat.com, f4bug@amsat.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DQiLaV9xIG6A9V0Avf76DIon8E68ePkoj
From: Eric Blake <eblake@redhat.com>
To: Kamil Rytarowski <n54@gmx.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, marcandre.lureau@gmail.com, armbru@redhat.com,
 f4bug@amsat.org
Message-ID: <6ee03c9d-3c42-4f73-1ca9-313f50be63df@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ivshmem-server: ivshmem-client: Build when
 eventfd() is available
References: <20170526054013.299-1-n54@gmx.com>
 <20170530062022.5841-1-n54@gmx.com>
 <58d04e43-1caa-f623-44fe-749dd351fad9@redhat.com>
 <42633e66-7ef4-c4ef-18d3-d2be588b816c@gmx.com>
In-Reply-To: <42633e66-7ef4-c4ef-18d3-d2be588b816c@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/30/2017 08:11 AM, Kamil Rytarowski wrote:

>>
>> Is this a v2 patch? If so, it's best to repost it as a new top-level
>> thread rather than buried in reply to your v1 patch.  Also, be sure to=

>> include v2 in the subject line ('git send-email -v2' works wonders for=

>> that).
>>

>=20
> I reworked it, fixed title and it's more like v3.
>=20

> Do I still need to resend it?
>=20

A human maintainer can often (eventually) figure out what's going on if
you don't, but resending is easier if you want to ensure the automated
patch tools don't lose things.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--DQiLaV9xIG6A9V0Avf76DIon8E68ePkoj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLXwRAAoJEKeha0olJ0NqjC4IAJ7oOF69epAMThSeiQIWuWLi
mSycGqhjJOgxoXgIS1jF870ajUcYGIn+nzLTwtMnHm9biIW8IAO3JvXjPjUyC165
Ul6gc20VzbTt5NUWGfK8M4+Ov1CAIlLSiz0nAAaeoh3WsiTT6khJe+hDEs/tzimC
cHORhbxEQUrRsHfGDm02GodWvIz1FcBGNORtCfr+gxPKK39nrincxzZUKvgTsLRC
6+iextQwzrxxeczm6mMUsqiWpP0LQMujoXrMr57jfSe8PP1IQBobhGzZnjtnAgT9
fa2jTjh2nbqAzhO/p6z9wp6S4aNjkfHYlVgwtyz4Klz2IvDQwqXkAyJWEVApMm0=
=nxGV
-----END PGP SIGNATURE-----

--DQiLaV9xIG6A9V0Avf76DIon8E68ePkoj--
