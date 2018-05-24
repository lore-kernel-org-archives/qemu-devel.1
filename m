Received: from eggs.gnu.org ([2001:4830:134:3::10]:33901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fLueJ-0002u5-74
	for qemu-devel@nongnu.org; Thu, 24 May 2018 14:07:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fLueE-0002Ba-5z
	for qemu-devel@nongnu.org; Thu, 24 May 2018 14:07:39 -0400
References: <20180524053958.5554-1-mark.cave-ayland@ilande.co.uk>
	<0d9436e3-9514-8d78-9c39-7d7da75ea8e8@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7ee18cd2-1170-1f6a-e215-a0454aec1151@redhat.com>
Date: Thu, 24 May 2018 20:07:25 +0200
MIME-Version: 1.0
In-Reply-To: <0d9436e3-9514-8d78-9c39-7d7da75ea8e8@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="hzRMfM6eiKa2PIoGKBQ6MYc4oevp1OcDZ"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] prep: fix keyboard for the 40p
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, hpoussin@reactos.org, david@gibson.dropbear.id.au

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hzRMfM6eiKa2PIoGKBQ6MYc4oevp1OcDZ
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, hpoussin@reactos.org, david@gibson.dropbear.id.au
Message-ID: <7ee18cd2-1170-1f6a-e215-a0454aec1151@redhat.com>
Subject: Re: [Qemu-ppc] [Qemu-devel] [PATCH] prep: fix keyboard for the 40p
 machine
References: <20180524053958.5554-1-mark.cave-ayland@ilande.co.uk>
 <0d9436e3-9514-8d78-9c39-7d7da75ea8e8@amsat.org>
In-Reply-To: <0d9436e3-9514-8d78-9c39-7d7da75ea8e8@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24.05.2018 18:20, Philippe Mathieu-Daud=C3=A9 wrote:
> On 05/24/2018 02:39 AM, Mark Cave-Ayland wrote:
>> Commit 72d3d8f052 "hw/isa/superio: Add a keyboard/mouse controller (80=
42)"
>> added an 8042 keyboard device to the PC87312 superio device to replace=
 that
>> being used by the prep machine.
>>
>> Unfortunately this commit didn't do the same for the 40p machine which=
 broke
>> the keyboard by registering two 8042 keyboard devices at the same addr=
ess.
[...]
> Thanks for fixing this (too bad there are no keyboard qtests and this
> got unnoticed).

Then it's time to write some tests? ;-)

 Thomas


--hzRMfM6eiKa2PIoGKBQ6MYc4oevp1OcDZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJbBv9hAAoJEC7Z13T+cC211YAP/2aWowJR3xRgKQh2qF8lKSiG
cyd7TE8q3C8ZSvSgTX4ZJ7xlrsJEqTc/kjNkYt9kHvXQvEPQlE3Eu66ZW6H/dKjy
LsSyL29HgklOsDscQP8iBJzhvbwTAnhefvO1AZSyfGUQP3FsEJg68K+w25syantR
Ky+LPSV4oBJFlSvwOooM0SUuIyhSkZm2qsArYpMN48U+qIeuK5JHbkWgBPluqkKL
vK+mMXK5M7xEjNlKomTYzL6zuiBVHjjItBmKhestIWtJlaXVR1goOXxhdMQXzawl
sRakB7BJXmcztc+Qb2MXPop8zvwiYGCvZKF2JN8S0QnCBo6Ii3E75cRXKXD4rNyk
Hkiiv5VW+4S25nocMb2hjxuMzIxmA5FbXBjco/3eky+HERabDQMCYPQ4P7kuFG45
fe+L+YtvJlU/KStyQdHtM7A4Dd+gga4P4sJ3GoA0fPbHLGQVtOgCnMvIAlnXfoMq
eQyPDbKSx4EXz/ogV78XY/c0YnsBP0ncYWwV9t4OtiRUTIhfrqz4ZgpyumJBERnG
53/+c2coGuXxbvHFAdEMEeFRkZCsRaFr272QKHPxEZIgKif3Dywf/QJ4+faF6A7t
q483PboNt9KulNK9T3rqyUQ42B2ailPb2wOpELdx59rT9VLwUt31EEGxzgGHdMdj
VbrOQDJwW66frR5KCMbO
=dpVP
-----END PGP SIGNATURE-----

--hzRMfM6eiKa2PIoGKBQ6MYc4oevp1OcDZ--
