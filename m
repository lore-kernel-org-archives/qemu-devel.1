Received: from eggs.gnu.org ([2001:4830:134:3::10]:42176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dB4ML-0001GA-A1
	for qemu-devel@nongnu.org; Wed, 17 May 2017 15:11:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dB4MK-0008FN-76
	for qemu-devel@nongnu.org; Wed, 17 May 2017 15:11:45 -0400
References: <684185116.2952708.1495044580181.ref@mail.yahoo.com>
	<684185116.2952708.1495044580181@mail.yahoo.com>
	<3293e70a-71ac-2e6d-433f-06346ad253c9@redhat.com>
	<107015620.2969780.1495046091978@mail.yahoo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5a2b9e50-1444-af4a-dc89-021a4beca0f4@redhat.com>
Date: Wed, 17 May 2017 14:11:29 -0500
MIME-Version: 1.0
In-Reply-To: <107015620.2969780.1495046091978@mail.yahoo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DPfjjcQ19wK2mihQNMBcmAl6d2EMNkmG1"
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
--DPfjjcQ19wK2mihQNMBcmAl6d2EMNkmG1
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
Message-ID: <5a2b9e50-1444-af4a-dc89-021a4beca0f4@redhat.com>
Subject: Re: [Qemu-devel] Add Markus Armbrusters code for Broadcom Perhiperals
 for ARM.
References: <684185116.2952708.1495044580181.ref@mail.yahoo.com>
 <684185116.2952708.1495044580181@mail.yahoo.com>
 <3293e70a-71ac-2e6d-433f-06346ad253c9@redhat.com>
 <107015620.2969780.1495046091978@mail.yahoo.com>
In-Reply-To: <107015620.2969780.1495046091978@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/17/2017 01:34 PM, John Bradley wrote:
> This is especial true as I meant Andrew Baumann 0xabu (Andrew Baumann)

Top-posting is not nice on technical lists.

> 0xabu (Andrew Baumann)
>  0xabu has 3 repositories available. Follow their code on GitHub.  |   =
|

Using github requires the use of non-free (as in freedom) Javascript.
That's why this list prefers that all patches be sent through the list
as emails, not as github pull requests.  I'm not going to look at what
0xabu's repository contains, but rather at what you send through the
list. But part of the contract of Signed-off-by is that you have
permission to post the patch and agree to the license in use - which
means that if your work is a modified version of Andrew Baumann's work,
then you need Andrew Baumann's sign-off before you can add yours.

Other hints for better patch submission may be found here:
http://wiki.qemu.org/Contribute/SubmitAPatch

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--DPfjjcQ19wK2mihQNMBcmAl6d2EMNkmG1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZHKBkAAoJEKeha0olJ0NqwzEH/iIb0gbYYFT++9USJ+jM5Bj5
HXtxwI5vB3fvVjTxDM34Y+NtrnlUtebna6D57xdhaLQaiakR/EcGyWHhmQ6NbevF
ZlmDpNLqHSAd87ZHJ5gFiFLz9QWxNOTdORip7qdRnxzu3fu4mHvnRTNQ+4zNIIKH
nHxRPDLmg4s6KiSq4s5jPid5GmuKmECiT9eNo+/SWvnpdBOjl7EaR6AujbtI9xE1
4l5IsFjPZOQUBz38EYd1k87jrs2NAv4lMuuaV5VqPR/5VElTgWb5611Q77wEQx3D
4inuMiLhcs1btvKuAxuoWX76NQnnFo58OeRgVOZKXA5Fzxi3OX9QOEh+tcPESOg=
=MTMB
-----END PGP SIGNATURE-----

--DPfjjcQ19wK2mihQNMBcmAl6d2EMNkmG1--
