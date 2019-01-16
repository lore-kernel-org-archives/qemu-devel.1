Received: from eggs.gnu.org ([209.51.188.92]:45296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjmPi-00015c-W1
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:43:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjmPh-0008Gw-99
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:43:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42113)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gjmPg-0008BU-NO
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:43:29 -0500
References: <1547196148-12250-1-git-send-email-thuth@redhat.com>
	<b1db55de-6741-76c7-33b1-74fc2692b82c@redhat.com>
	<552ac2db-6568-18f8-5397-a00c4b432df9@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <23057d08-76cd-0ab8-d940-974ed3d1d1a0@redhat.com>
Date: Wed, 16 Jan 2019 08:43:21 -0600
MIME-Version: 1.0
In-Reply-To: <552ac2db-6568-18f8-5397-a00c4b432df9@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="P9jabuiEARRuHjaTMu6y6ezd2Qmn9Wobg"
Subject: Re: [Qemu-devel] HACKING vs. CODING_STYLE (was: Re: [PATCH]
 HACKING: Clarify the paragraph about typedefs)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Greg Kurz <groug@kaod.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P9jabuiEARRuHjaTMu6y6ezd2Qmn9Wobg
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Greg Kurz
 <groug@kaod.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <23057d08-76cd-0ab8-d940-974ed3d1d1a0@redhat.com>
Subject: Re: HACKING vs. CODING_STYLE (was: Re: [PATCH] HACKING: Clarify the
 paragraph about typedefs)
References: <1547196148-12250-1-git-send-email-thuth@redhat.com>
 <b1db55de-6741-76c7-33b1-74fc2692b82c@redhat.com>
 <552ac2db-6568-18f8-5397-a00c4b432df9@redhat.com>
In-Reply-To: <552ac2db-6568-18f8-5397-a00c4b432df9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/16/19 4:58 AM, Thomas Huth wrote:
> On 2019-01-11 11:38, Paolo Bonzini wrote:
> [...]
>> And, I would move it to CODING_STYLE since we are at it. :)
>=20
> I just got some feedback in IRC already, and seems like I am not alone,=

> so let's discuss it here on the mailing list, too: What's the exact
> difference between CODING_STYLE and HACKING? Some of the paragraphs in
> HACKING sound rather mandatory and coding-style related, too...
> Should we maybe merge the two files into one (e.g. called "CODING")?

Merging the files sounds reasonable to me.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--P9jabuiEARRuHjaTMu6y6ezd2Qmn9Wobg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw/QwkACgkQp6FrSiUn
Q2rnPgf/RgRt2/oHhks2l/VVSTTYk+Yu78l9ozQfpBvycNyIqIjKd5YvOAw3+Un2
dbo4S6Al6IVV1Grmex3EEbWIxBy/j7dIr/XV6EG0GUI/N1FB/ijxlfwrtEyHw+Jb
E1mreesm2NY2cY7A4Xnw/TuutOkIerRYrjv9Rsjy6pSqdXmrgP0jprOySQ1YCouw
ggkhpCrNNKFtdV5zCcKiiu6tNJ7pM8ZIyl+lmHbO7NnrY9cHfZc0u8FuXn2scRXD
XqLiPQthhYP9IhHVUWCUVB+5tTEf4Jew6P1y6LSyWWgFX0epJ1ahtcAcTCQUoP+5
qzKUNkwEnZzcBxscLpzys5sm2+ukLw==
=gYNW
-----END PGP SIGNATURE-----

--P9jabuiEARRuHjaTMu6y6ezd2Qmn9Wobg--
