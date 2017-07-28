Received: from eggs.gnu.org ([2001:4830:134:3::10]:59519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db4EK-0005d7-Gc
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:18:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db4EJ-0002bL-KG
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:18:56 -0400
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-47-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e17ab1d2-3ee8-3a5e-b91f-fdd7d44e1783@redhat.com>
Date: Fri, 28 Jul 2017 07:18:49 -0500
MIME-Version: 1.0
In-Reply-To: <20170728053610.15770-47-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="s4Ujwo1tEfExk72AHB7PRWkmA6aEPlJ60"
Subject: Re: [Qemu-devel] [RFC PATCH 46/47] MAINTAINERS: add missing entries
 for Coccinelle scripts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s4Ujwo1tEfExk72AHB7PRWkmA6aEPlJ60
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Message-ID: <e17ab1d2-3ee8-3a5e-b91f-fdd7d44e1783@redhat.com>
Subject: Re: [RFC PATCH 46/47] MAINTAINERS: add missing entries for Coccinelle
 scripts
References: <20170728053610.15770-1-f4bug@amsat.org>
 <20170728053610.15770-47-f4bug@amsat.org>
In-Reply-To: <20170728053610.15770-47-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/28/2017 12:36 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> and voluntary myself as reviewer

s/voluntary/volunteer/

>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>=20
> I'm not a Coccinelle specialist but willing to learn and help!
>=20

I'm not sure adding an orphan-only section helps; and some of the
particular scripts have specific maintainers (qobject.cocci).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--s4Ujwo1tEfExk72AHB7PRWkmA6aEPlJ60
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll7K6kACgkQp6FrSiUn
Q2rAPAf9ERacisn5Tl1N45wveBDWN08gODdMJMaXo0Fpst53SM0yof80VT6OeVIK
IDKqmGo0TEodi1b7wWoK4/4od3pP9r0Lm4SV2hFCx3JWlmmKPwCpnkSsYOtuPbpM
P98pE1YtInD73Yg6jRxmavs5yd+sbhirpg9Vmef537JVuyK9Wbto/7EaCGxTLabe
hwEhacC1LxPpc7Jv28ZAXe+FvXuMsRTwR4v0M15e9/Ka4gSWj+RbOkaPIiplK24m
ZR5gb3nSxe/lpUt9NkQIg0EIL8eBVWWONUkdBWx80BXCnxYe5vnMfZH/HHus59ew
PqzcAg0lzYfZnU+TK3C+ORWa0xqBeg==
=lmJz
-----END PGP SIGNATURE-----

--s4Ujwo1tEfExk72AHB7PRWkmA6aEPlJ60--
