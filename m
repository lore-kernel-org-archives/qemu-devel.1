Received: from eggs.gnu.org ([2001:4830:134:3::10]:42775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cZew0-0005M1-27
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 09:33:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cZevw-0000bu-Sx
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 09:33:56 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cZevw-0000b4-M7
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 09:33:52 -0500
Received: by mail-wm0-x242.google.com with SMTP id r18so4737124wmd.3
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 06:33:52 -0800 (PST)
Date: Fri, 3 Feb 2017 14:33:49 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170203143349.GA642@stefanha-x1.localdomain>
References: <20170201132456.11406-1-stefanha@redhat.com>
	<CAFEAcA8DispSgt8ABVCTOtQbt153qVXk0wO+afunQNsZahFyZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <CAFEAcA8DispSgt8ABVCTOtQbt153qVXk0wO+afunQNsZahFyZQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/1] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 02, 2017 at 04:07:16PM +0000, Peter Maydell wrote:
> On 1 February 2017 at 13:24, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > The following changes since commit a0def594286d9110a6035e02eef558cf3cf5=
d847:
> >
> >   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into=
 staging (2017-01-30 10:23:20 +0000)
> >
> > are available in the git repository at:
> >
> >   git://github.com/stefanha/qemu.git block-pull-request
> >
> > for you to fetch changes up to 81a9f2cb9336a7e9f50b0729b4c81d287e0015e9:
> >
> >   iothread: enable AioContext polling by default (2017-01-31 17:09:34 +=
0000)
>=20
> git claims not to be able to find "block-pull-request",
> and https://github.com/stefanha/qemu/tags says it was
> pushed 7 days ago with a different commit hash to the
> one quoted here. Forgot to tag? Forgot to push?

I must have messed something up.

NACK

Will send a fresh pull request.

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYlJTNAAoJEJykq7OBq3PIXEwIAJElxuzRpizWh3OaW6nzz5Xd
RVFHHRnaFVdU0WL4MpEez5zf8NJSI6ypTCmmR5rA6KxKBDjTrUeGZ6uZwivUPGCx
bmoPjXKhr+sLBdAzFDgJGyo0ZptHi0H6+0yFYqlnN9lnZfvt7lQ4XoO/1ll4agJI
yFc9NS3Cberuxu35rXjWcnxlRLiVjacIxXWTelitdID62HdqWIZ5Ml0qbDWDLE1T
721TtX99H1QM+oPCLTeqApNJb6uYp414vluwk2PzPWB76w4ZQI5d/kSOf1FgXPc6
rpLhGeHoSf2chNMzBeQk3Net588M9FqDeO5/Qu8Rv3snbw5odtffCCdyhl3BSmU=
=ss1z
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
