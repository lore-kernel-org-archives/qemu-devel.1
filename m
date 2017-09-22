Received: from eggs.gnu.org ([2001:4830:134:3::10]:46965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dvV5i-0002zo-9v
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 17:02:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dvV5f-0007zb-8a
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 17:02:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31839)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dvV5e-0007zG-W7
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 17:02:27 -0400
References: <20170921170209.9101-1-ehabkost@redhat.com>
	<7ad0e182-536b-42d8-5b80-bfcd03612a00@redhat.com>
	<20170922033026.GE1397@lemon.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3f6252b9-0e25-e8d7-aa6e-cc54497a96f9@redhat.com>
Date: Fri, 22 Sep 2017 16:02:21 -0500
MIME-Version: 1.0
In-Reply-To: <20170922033026.GE1397@lemon.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="g6m3wIEKr3Oa4EjHdnVGvdsI8nvJhlMN4"
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Fix subsystem name for "Build
 and test automation"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g6m3wIEKr3Oa4EjHdnVGvdsI8nvJhlMN4
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Message-ID: <3f6252b9-0e25-e8d7-aa6e-cc54497a96f9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Fix subsystem name for "Build
 and test automation"
References: <20170921170209.9101-1-ehabkost@redhat.com>
 <7ad0e182-536b-42d8-5b80-bfcd03612a00@redhat.com>
 <20170922033026.GE1397@lemon.lan>
In-Reply-To: <20170922033026.GE1397@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/21/2017 10:30 PM, Fam Zheng wrote:

>>>  Build and test automation
>>>  -------------------------
>>> +Build and test automation
>>
>> Would it make sense to use something more specific here? Like "Travis
>> and Docker" or so? ... in case we add other subsections in the future?=

>=20
> Unless we are to split off (i.e. more people volunteering maintaining a=
 certain
> subset), the list will just go on and on in this line. For not it's alr=
eady
> going to be "Travis, Shippable, Docker and VM test".. so I think a gene=
ric
> description here is okay, though the duplication is a bit odd (but I do=
n't have
> a better idea).

Or we could make a generic section of "Build, Tests, and Documentation",
and merge in the "Build system architecture" of the
immediately-subsequent "Documentation" section, as well as possibly any
future sections for someone to maintain top-level build-related files
(including MAINTAINERS itself...), so that we have just one larger
section with multiple sub-sections, instead of two sections each with
one sub-section.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--g6m3wIEKr3Oa4EjHdnVGvdsI8nvJhlMN4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnFel0ACgkQp6FrSiUn
Q2qCXwf9EfBcZ5FwObyqQMWS/iFbvm7N3GKl649c/Pp9WGJlbNmSlDUFpelkTa+B
Xq7xH7FISrhUcdcsY4xe2KgRYiIKL1dnTYV3dnqWvnG9vr5eU7xcJiLHzK3w1Gfj
0fQC0UoH4xwHup2e1jNxbpLmJGBc4HGh7gIfxdvGZI6kQACSkNFiQc/s35lQWaGs
AsQI/QDIkZ8IGBHJk6NRnqNbntwBZCxsYg60t/CFwMnQBEgSAGazz+dj9x8BROcL
ZGIBQu9hWNJQVRroBcSPGegVcUdrDfmD9YVb693UIMlnGISCAZPt5s7YLPjvJ1Yi
WX/45k+HfLgD00SvEmEDNx4zxDx8pg==
=1cjJ
-----END PGP SIGNATURE-----

--g6m3wIEKr3Oa4EjHdnVGvdsI8nvJhlMN4--
