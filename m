Received: from eggs.gnu.org ([2001:4830:134:3::10]:35179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmMOl-00087X-Bx
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 11:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmMOh-0000TL-HP
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 11:56:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dmMOh-0000Qt-7m
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 11:56:19 -0400
References: <cover.1503249785.git.balaton@eik.bme.hu>
	<alpine.BSF.2.21.1708271402040.1289@zero.eik.bme.hu>
	<AM5P194MB01323322D359DF607B54C19EC8990@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d2917c22-1a10-eb39-17c7-be5096c400db@redhat.com>
Date: Mon, 28 Aug 2017 10:56:14 -0500
MIME-Version: 1.0
In-Reply-To: <AM5P194MB01323322D359DF607B54C19EC8990@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="b7Cx9qpj7fBuNEmm5lfmuqd2CDCKcj1dR"
Subject: Re: [Qemu-devel] Qemu 2.10 rc4 build issue on BE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: luigi burdo <intermediadc@hotmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b7Cx9qpj7fBuNEmm5lfmuqd2CDCKcj1dR
From: Eric Blake <eblake@redhat.com>
To: luigi burdo <intermediadc@hotmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <d2917c22-1a10-eb39-17c7-be5096c400db@redhat.com>
Subject: Re: [Qemu-devel] Qemu 2.10 rc4 build issue on BE
References: <cover.1503249785.git.balaton@eik.bme.hu>
 <alpine.BSF.2.21.1708271402040.1289@zero.eik.bme.hu>
 <AM5P194MB01323322D359DF607B54C19EC8990@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
In-Reply-To: <AM5P194MB01323322D359DF607B54C19EC8990@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/27/2017 11:56 AM, luigi burdo wrote:
> Hi all,
>=20
> the last rc4 from the qemu website fail in build in some parts on BE ha=
rdware.

Please don't commandeer unrelated threads (replying to an existing
message sets up In-Reply-To: and References: headers that thread your
mail to the previous one, even if you change the subject and drop all
previous content; it would have been better to post your message as a
top-level thread instead of buried in an unrelated thread).

https://lists.gnu.org/archive/html/qemu-devel/2017-08/threads.html#03659
demonstrates how your message was inappropriately threaded to
"[Qemu-ppc] [PATCH 00/15] Sam460ex emulation"

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--b7Cx9qpj7fBuNEmm5lfmuqd2CDCKcj1dR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmkPR4ACgkQp6FrSiUn
Q2o+iQf/Y5h7QntXn+gRg44IMRQoLaxM0r/SJpB6HGgHGM0vAMeG+dTeEyKkK1go
pyR6U5el187lchIU34CEWbtPrcmlCbouk3mdPOvD9pj0aRnoy1YEMS+aqUWXmxRD
beuWHNsdzPtUfga1O8HwVXQWSdysHRvFPkGGK762Fbbc6JvVP543j7/n2LuBg2CN
GlxxcTv2WPSbTswxrGZCnaHapRBbGyJUBcmdpyjpQkyEfj/orSjjWWhBjYtjJC+K
04jRucQ5KaqAuXWazbHJ7Z3eVstwZiBhjxwStu4jBApTvZe1arD5TCwUR1Aisn0g
bxi7wiSsF+gpUOT6SprtViGLe5Iodw==
=tHGy
-----END PGP SIGNATURE-----

--b7Cx9qpj7fBuNEmm5lfmuqd2CDCKcj1dR--
