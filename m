Received: from eggs.gnu.org ([2001:4830:134:3::10]:47348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnS6S-00030c-RZ
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:14:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnS6P-0005zL-LP
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:14:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dnS6P-0005zE-CK
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:13:57 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6C602C0467C6
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 16:13:56 +0000 (UTC)
References: <20170831131425.3953-1-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <36055f63-58c7-7346-21fb-60ee42874430@redhat.com>
Date: Thu, 31 Aug 2017 11:13:38 -0500
MIME-Version: 1.0
In-Reply-To: <20170831131425.3953-1-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="x7WULSIKWs75VjnV1HHIE9BU6cixqIDuX"
Subject: Re: [Qemu-devel] [PATCH 1/2] .dir-locals.el: add makefiles to
 auto-mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--x7WULSIKWs75VjnV1HHIE9BU6cixqIDuX
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <36055f63-58c7-7346-21fb-60ee42874430@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] .dir-locals.el: add makefiles to
 auto-mode
References: <20170831131425.3953-1-marcandre.lureau@redhat.com>
In-Reply-To: <20170831131425.3953-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/31/2017 08:14 AM, Marc-Andr=C3=A9 Lureau wrote:
> QEMU uses non-conventional makefile filenames. Ease the life of emacs
> developpers a bit by appending to the auto-mode-alist.

s/emacs developpers/developers using emacs/ (typo, and avoids an
ambiguity on whether you are describing people that develop emacs rather
than qemu)

>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---

The idea itself makes sense to me; although I'm not enough of a Lisp
guru to state if your changes are the ideal way to do it.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--x7WULSIKWs75VjnV1HHIE9BU6cixqIDuX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmoNbIACgkQp6FrSiUn
Q2oSWAf/dsoL7QkR9QCUGPrqP8vXp/RG2zGOI1oKoS9dWsl6UT0Pnkn0Q6XxlvOC
Pu3VmCZTbIPlfSUb8JTrlQRuvWFKe+U8+Anp6kyNYyI0YzbOR/ov9rA5xiwH6VUg
rtwihg6i1Hkrwlq4IOA6P1rA5m3vwnvtuYutkyaMOPIPw00cjyYeJjU1/gWlvbCU
FguTzOapoi+CvRex3jMbeZH0hDVT1IGVtVsWscif4dcGIbpzbvFNGzk3rQGqTCZj
h2pu5WSxTD9f/wb312r3UZR1XHI8LDbPArkRBrILEnO3T0an/x0Dy3rTGkRDhvs4
W+/IF5R2Xd41dsmJXDP6zpN0EF2Cpg==
=pc45
-----END PGP SIGNATURE-----

--x7WULSIKWs75VjnV1HHIE9BU6cixqIDuX--
