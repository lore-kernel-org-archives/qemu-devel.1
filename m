Received: from eggs.gnu.org ([2001:4830:134:3::10]:50740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dB6vA-0001RR-BN
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dB6v9-0002Q5-1u
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:55:52 -0400
References: <684185116.2952708.1495044580181.ref@mail.yahoo.com>
	<684185116.2952708.1495044580181@mail.yahoo.com>
	<3293e70a-71ac-2e6d-433f-06346ad253c9@redhat.com>
	<107015620.2969780.1495046091978@mail.yahoo.com>
	<5a2b9e50-1444-af4a-dc89-021a4beca0f4@redhat.com>
	<1832071588.99743.1495054408073@mail.yahoo.com>
	<bcff9cd4-3ec2-0757-02e0-96f0e0a7747e@redhat.com>
	<968647832.156883.1495056309814@mail.yahoo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d7324134-4eb5-0ca2-2a13-6fd5c5479b49@redhat.com>
Date: Wed, 17 May 2017 16:55:41 -0500
MIME-Version: 1.0
In-Reply-To: <968647832.156883.1495056309814@mail.yahoo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EaKpOq8SvgUbA8I5hnDHCiceSTj5P7eVu"
Subject: Re: [Qemu-devel] Add Markus Armbrusters code for Broadcom
 Perhiperals for ARM.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Bradley <flypie1@yahoo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: John Bradley <flypie@rocketmail.com>, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Geert Martin Ijewski <gm.ijewski@web.de>, Markus Armbruster <armbru@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EaKpOq8SvgUbA8I5hnDHCiceSTj5P7eVu
From: Eric Blake <eblake@redhat.com>
To: John Bradley <flypie1@yahoo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: John Bradley <flypie@rocketmail.com>, Laurent Vivier
 <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Geert Martin Ijewski <gm.ijewski@web.de>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@xilinx.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d7324134-4eb5-0ca2-2a13-6fd5c5479b49@redhat.com>
Subject: Re: [Qemu-devel] Add Markus Armbrusters code for Broadcom Perhiperals
 for ARM.
References: <684185116.2952708.1495044580181.ref@mail.yahoo.com>
 <684185116.2952708.1495044580181@mail.yahoo.com>
 <3293e70a-71ac-2e6d-433f-06346ad253c9@redhat.com>
 <107015620.2969780.1495046091978@mail.yahoo.com>
 <5a2b9e50-1444-af4a-dc89-021a4beca0f4@redhat.com>
 <1832071588.99743.1495054408073@mail.yahoo.com>
 <bcff9cd4-3ec2-0757-02e0-96f0e0a7747e@redhat.com>
 <968647832.156883.1495056309814@mail.yahoo.com>
In-Reply-To: <968647832.156883.1495056309814@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/17/2017 04:25 PM, John Bradley wrote:
> Well unfortunately Eric. I don't understand your "top posted" slang.

To learn what top-posting is:
http://lmgtfy.com/?q=3Dwhat+is+top-posting

and why we don't like it on technical lists:
http://www.caliburn.nl/topposting.html

Or more humorously:

A: Yes.
> >Q: Are you sure?
>> >>A: Because it reverses the logical flow of conversation.
>>> >>>Q: Why is top posting frowned upon?

>=20
> As for his "intent", it is quite irrelevant as I have gone over the cod=
e line by line and what every he intended to do, he has succeed, as far a=
s I can tell , in matching you standards, to such an extent that I am hap=
py that=20

You are correct that the GPL gives us legal rights to use Andrew's code
without his permission.  And yes, YOU can fork qemu, and take whatever
GPL patches you want without attribution, and you are probably still
just fine legally (as long as you still abide by the GPL in that you
distribute sources to anyone that has your binary).

But our project rules do not allow us to live by just GPL (in part,
because the license of qemu is sometimes tricky to determine due to a
mix of GPLv2-only code and non-GPL code, even though most new code is
GPLv2+).  Also, if we ever had a reason to change license (supposing it
is even possible, although it might require ripping out or
reimplementing portions of the code base), having S-o-b means that we
cannot be accused of applying a license that someone did not agree to.

Therefore, it is easier, pragmatically, even if not legally necessary,
to enforce proper chain of authorship by getting Signed-off-by: tags on
ALL patches, especially where a patch asserts a copyright owner, insofar
as the original copyright owner is still alive and able to assent to the
action.  It is not just about legalities, it is also about risk-avoidance=
=2E

It may sound like we are being hard-nosed (and so be it), but there's a
reason that we list proper Signed-off-by: rules as our number 1 item on
the SubmitAPatch page.
http://wiki.qemu.org/Contribute/SubmitAPatch

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--EaKpOq8SvgUbA8I5hnDHCiceSTj5P7eVu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZHMbdAAoJEKeha0olJ0NqMTMH/3rmjWw3uJ7m0I94r+JWi4yb
EHU8Gq6WOR3ijxZp66szfvP/dE7IaG8Z8JdlFUizAPc3siBVjjmEGDmz/3/2b1fN
ffaO8tBtfhEYpn/CfsOo//+dRTnSBeijSEY8VW5SjMARgFBOX3gNWvTXD1l3eoxu
0WIXydKpatAcCfS9FES+FPDq/2xZ+oRXFUrgggOIuH1Cr23jGIDDvxpU+d1e+7Z6
lEzdO3Esw0dyQAN5+1BSR89D9Z4bmjw9xkYzYGb/mrPyI6UQ4XVlU8AXXVJfAe+P
2mJIdur6ZRfJKEHFf2JJ6dJUtO4o5RloeHnbpHxkKAPWG+FD2wzACrwjKj5DysI=
=v7Aw
-----END PGP SIGNATURE-----

--EaKpOq8SvgUbA8I5hnDHCiceSTj5P7eVu--
