Received: from eggs.gnu.org ([2001:4830:134:3::10]:42068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXTt9-0001Ih-MX
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:54:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXTt8-0007sw-PJ
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:54:15 -0400
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<1500385286-21142-4-git-send-email-armbru@redhat.com>
	<e6f2611e-ff9f-450c-a438-e740c2b57ece@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c61aee5a-a094-50c3-67c3-c39e72095710@redhat.com>
Date: Tue, 18 Jul 2017 09:54:09 -0500
MIME-Version: 1.0
In-Reply-To: <e6f2611e-ff9f-450c-a438-e740c2b57ece@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FJ11MoqrteEna0CDj1xsbbcjsGlSLDD8c"
Subject: Re: [Qemu-devel] [PATCH for-2.10 03/10] qapi: Introduce a first
 class 'null' type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FJ11MoqrteEna0CDj1xsbbcjsGlSLDD8c
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com
Message-ID: <c61aee5a-a094-50c3-67c3-c39e72095710@redhat.com>
Subject: Re: [PATCH for-2.10 03/10] qapi: Introduce a first class 'null' type
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
 <1500385286-21142-4-git-send-email-armbru@redhat.com>
 <e6f2611e-ff9f-450c-a438-e740c2b57ece@redhat.com>
In-Reply-To: <e6f2611e-ff9f-450c-a438-e740c2b57ece@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2017 09:53 AM, Eric Blake wrote:
> On 07/18/2017 08:41 AM, Markus Armbruster wrote:
>> I expect the 'null' type to be useful mostly for members of alternate
>> types.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>=20

> Reviewed-by: Eric Blake <eblake@redhat.com>

Actually, do we need to update any qapi docs to mention the new builtin
type?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--FJ11MoqrteEna0CDj1xsbbcjsGlSLDD8c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlluIREACgkQp6FrSiUn
Q2ontQf8C2LohXtYZGLvfZc6YoEcqVWSp0/mXB7zSFSJo7l3cvh3Enz+XQaoA/1u
0NTb+cdIQ4ZAPLGGBEzwfr1vJHTXrJqRF0wQXiFX2AuiWacxw2fUnLWD4lTB91e5
1LHbMTcE+UxwAOnNXsxEPnyvUS6Wq3dAdKwFfj4S2+VcQeXaEselH1kiFQ0WuHYH
Qswe8TnEPPKzis7IE8FYJbwKExZqoJuiwLxtJ0OXQqyDnzyb/GMN6kyaFqXTeijw
F0Z3facLxYAO8Kh43JcMlH2esFT4GAToHw0uzRjoWHl82UcukTbYmQq+yN1g4AZl
q3yS1lpocvjID8pl8rZmP7Rq0yM7gg==
=+dwt
-----END PGP SIGNATURE-----

--FJ11MoqrteEna0CDj1xsbbcjsGlSLDD8c--
