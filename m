Received: from eggs.gnu.org ([209.51.188.92]:50921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grpBO-0007eT-5L
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 14:17:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grpBN-0001ZB-AU
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 14:17:58 -0500
References: <20190114162605.5330-1-eblake@redhat.com>
	<20190114162605.5330-20-eblake@redhat.com>
	<CAFEAcA83L0jFLVDK8ebF2pxtAqoM+YsTU2vYUx2y7-PbSuEW9g@mail.gmail.com>
	<60feac5a-d45e-bfd0-b0c8-45e16aa95e6b@redhat.com>
	<CAFEAcA93i079grGNsNurdme8Et-Up_hg+_R0txXAXUYdLCxpFg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cd0f9e38-cc1f-2d53-b1fd-3d59340cb5eb@redhat.com>
Date: Thu, 7 Feb 2019 13:17:41 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA93i079grGNsNurdme8Et-Up_hg+_R0txXAXUYdLCxpFg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XrAZVfxNGHXUHpV8ja2ouCGgfZQ8Yo7cS"
Subject: Re: [Qemu-devel] [PULL 19/20] nbd: Merge nbd_export_bitmap into
 nbd_export_new
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XrAZVfxNGHXUHpV8ja2ouCGgfZQ8Yo7cS
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <cd0f9e38-cc1f-2d53-b1fd-3d59340cb5eb@redhat.com>
Subject: Re: [Qemu-devel] [PULL 19/20] nbd: Merge nbd_export_bitmap into
 nbd_export_new
References: <20190114162605.5330-1-eblake@redhat.com>
 <20190114162605.5330-20-eblake@redhat.com>
 <CAFEAcA83L0jFLVDK8ebF2pxtAqoM+YsTU2vYUx2y7-PbSuEW9g@mail.gmail.com>
 <60feac5a-d45e-bfd0-b0c8-45e16aa95e6b@redhat.com>
 <CAFEAcA93i079grGNsNurdme8Et-Up_hg+_R0txXAXUYdLCxpFg@mail.gmail.com>
In-Reply-To: <CAFEAcA93i079grGNsNurdme8Et-Up_hg+_R0txXAXUYdLCxpFg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/7/19 1:05 PM, Peter Maydell wrote:
> On Thu, 7 Feb 2019 at 19:00, Eric Blake <eblake@redhat.com> wrote:
>> (Someday, it would be
>> nice to turn -Wshadow on, to catch stuff like this sooner)
>=20
> Yes; unfortunately -Wshadow currently generates a ton of
> warnings in existing code which we'd need to fix to get
> the noise level down...

I've added the wish to https://wiki.qemu.org/BiteSizedTasks

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--XrAZVfxNGHXUHpV8ja2ouCGgfZQ8Yo7cS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxchFUACgkQp6FrSiUn
Q2qvcwf/b+c+1joKiyEwADUZX+NvR46gBgUCViGuNJEFJxa+F5qtlGaS0YLriAye
6ZQTO8yAR/P0AbT0newt/j+jrQNwtKbu3DHJf3U5yFlczIObvXpMp07b0/v+etWr
Qmd7rsavo6R4W8Jx40tOvgarSjn0rMIJwmKXoyfWPzv/JzxSaQ+mCmYPCtWf8iLr
on66ePGmtm7BqOD9aQpa7sdcQEfAtCiEgBX0lm+N6qUxhgd9cK3Q3093jXJHIWK1
tQM0YzoHY7ehOIk0+JTy3tGAT0nomsxLwEujqtEmV9YCZh4SsQWGQOawo59LPRD7
RV1Z2z1GaiFSxRhsU8+qD52f9VII8w==
=5wEv
-----END PGP SIGNATURE-----

--XrAZVfxNGHXUHpV8ja2ouCGgfZQ8Yo7cS--
