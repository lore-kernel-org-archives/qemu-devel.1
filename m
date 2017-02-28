Received: from eggs.gnu.org ([2001:4830:134:3::10]:37644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciig1-0008Px-Lw
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:22:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciifx-0001Wi-Oi
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:22:53 -0500
Received: from 14.mo6.mail-out.ovh.net ([46.105.56.113]:50055)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ciifx-0001Vr-IK
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:22:49 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id DD3F1B4241
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 15:22:46 +0100 (CET)
Date: Tue, 28 Feb 2017 15:22:40 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170228152240.6efc1fbc@bahia.lan>
In-Reply-To: <2a8da4e5-d66d-502c-322b-ec942f250f40@msgid.tls.msk.ru>
References: <1488277840-18608-1-git-send-email-groug@kaod.org>
	<2a8da4e5-d66d-502c-322b-ec942f250f40@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/.L4VFjGf7YOpzd2XaDM5fJn";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PULL 00/28] 9p CVE-2016-9602 fixes 2017-02-28 for
 2.9 soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Aneesh
	Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

--Sig_/.L4VFjGf7YOpzd2XaDM5fJn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Feb 2017 17:02:44 +0300
Michael Tokarev <mjt@tls.msk.ru> wrote:

> 28.02.2017 13:30, Greg Kurz wrote:
> > The following changes since commit 9b9fbe8a4e9eec9072ee2697a6af59144442=
785f:
> >=20
> >   Merge remote-tracking branch 'remotes/kraxel/tags/pull-ui-20170227-1'=
 into staging (2017-02-27 19:19:46 +0000)
> >=20
> > are available in the git repository at:
> >=20
> >   https://github.com/gkurz/qemu.git tags/cve-2016-9602-for-upstream
> >=20
> > for you to fetch changes up to c23d5f1d5bc0e23aeb845b1af8f996f16783ce98=
: =20
>=20
> Greg, did you forget to push maybe? There's no tag "cve-2016-9602-for-ups=
tream"
> and no object c23d5f1d5bc0e23aeb845b1af8f996f16783ce98.
>=20

I had pushed actually and...

https://github.com/gkurz/qemu/commits/cve-2016-9602-for-upstream

https://github.com/gkurz/qemu/commit/c23d5f1d5bc0e23aeb845b1af8f996f16783ce=
98

What's wrong ?

> Thanks,
>=20
> /mjt


--Sig_/.L4VFjGf7YOpzd2XaDM5fJn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAli1h7AACgkQAvw66wEB28I0+wCdEtZfmIHWprpSRxLN/EFQ3jEk
53sAn1uo4wepcZ20iuJyLt0RpfEnAYi8
=U0OR
-----END PGP SIGNATURE-----

--Sig_/.L4VFjGf7YOpzd2XaDM5fJn--
