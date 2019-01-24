Received: from eggs.gnu.org ([209.51.188.92]:35009)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1gmc8M-0002nS-Er
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:21:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1gmbtl-0005I6-T2
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:06:15 -0500
Received: from mout.gmx.net ([212.227.17.22]:33503)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1gmbth-00051S-NC
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:06:13 -0500
References: <20190123101238.GD27270@redhat.com>
	<379cce5d-71e1-b210-c0de-c0b8a478de3a@gmx.com>
	<CAFEAcA-HOjPGz2U4wXJ_ujbUmHn1V2PohiL8wPkPz8iV6TPSig@mail.gmail.com>
	<52937a07-9462-6910-610c-5b1ee5d2541a@gmx.com>
	<20190123122015.uvyqe4vsxhhgugz7@sirius.home.kraxel.org>
	<da0587e0-44a2-a0f8-3df4-628973db42fd@gmx.com>
	<20190123135903.v2jjfpsp5pqitva4@sirius.home.kraxel.org>
	<ddf0684d-37cb-1860-9b73-0b23bd5dbde6@comstyle.com>
	<20190123151257.3bchv7msj754jyt2@sirius.home.kraxel.org>
	<94b6e045-2348-b64b-048b-e585a236201c@gmx.com>
	<20190124063851.zhjlx5oigvri4r64@sirius.home.kraxel.org>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <bd206be0-3e7e-ad5c-f497-dc28b1904311@gmx.com>
Date: Thu, 24 Jan 2019 11:06:52 +0100
MIME-Version: 1.0
In-Reply-To: <20190124063851.zhjlx5oigvri4r64@sirius.home.kraxel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8QbrEHPJk2J0okaA6Bqlcyd50eMGtBqxg"
Subject: Re: [Qemu-devel] [PATCH 4/4] [RfC] audio: probe audio drivers by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Brad Smith <brad@comstyle.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8QbrEHPJk2J0okaA6Bqlcyd50eMGtBqxg
From: Kamil Rytarowski <n54@gmx.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Brad Smith <brad@comstyle.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <bd206be0-3e7e-ad5c-f497-dc28b1904311@gmx.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] [RfC] audio: probe audio drivers by
 default
References: <20190123101238.GD27270@redhat.com>
 <379cce5d-71e1-b210-c0de-c0b8a478de3a@gmx.com>
 <CAFEAcA-HOjPGz2U4wXJ_ujbUmHn1V2PohiL8wPkPz8iV6TPSig@mail.gmail.com>
 <52937a07-9462-6910-610c-5b1ee5d2541a@gmx.com>
 <20190123122015.uvyqe4vsxhhgugz7@sirius.home.kraxel.org>
 <da0587e0-44a2-a0f8-3df4-628973db42fd@gmx.com>
 <20190123135903.v2jjfpsp5pqitva4@sirius.home.kraxel.org>
 <ddf0684d-37cb-1860-9b73-0b23bd5dbde6@comstyle.com>
 <20190123151257.3bchv7msj754jyt2@sirius.home.kraxel.org>
 <94b6e045-2348-b64b-048b-e585a236201c@gmx.com>
 <20190124063851.zhjlx5oigvri4r64@sirius.home.kraxel.org>
In-Reply-To: <20190124063851.zhjlx5oigvri4r64@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24.01.2019 07:38, Gerd Hoffmann wrote:
>   Hi,
>=20
>>> https://xkcd.com/927/
>>
>> There is a different context on BSD than on Linux. We can choose one
>> solution and switch to it literally all the software keeping everythin=
g
>> in a single ports tree.
>>
>> This is what happened on OpenBSD.
>>
>> The result is that almost everything uses sndio, and pulseaudio is far=

>> behind in adoption in any distro.
>=20
> I'm not going to join the sndio vs. pulse discussion.
>=20
> But from a maintenance point of view it sucks big time to have a bunch
> of ways to play sound, and everybody uses a different one so you have t=
o
> maintain a backend for each of those methods.
>=20
> Maybe we should outsource that problem.  Write a gstreamer backend, the=
n
> delete oss/alsa/sdl/pulse/whatever backends and let gstreamer handle
> that mess ...
>=20

Just please leave it to OS maintainers.

There is no fragmentation in BSD distributions so sndio isn't different
to native sound system on Darwin or Windows and I see no complains that
Windows does not adapt PulseAudio. (Probably the only practical
difference is BSD being open-source.)

> cheers,
>   Gerd
>=20



--8QbrEHPJk2J0okaA6Bqlcyd50eMGtBqxg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlxJjksMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZsRn8QALoTXQmxxbkxgVYDI/L34Cwmf4iAsw3V83Yqb82f
cXxVGGGQ71ZCJGnuv/hUzeqzvwaEl2qgaMKre4SnjBN1FUkN2AQUR+8l5uYwWENH
zXx7DkG8kKgLtAFmHVUREhIyoDgMcjJTfG5cZwsTOCoOq4+2zez62AdpqR3OLBr7
Um3IA0tWt6kqvEDCShpJpibJQxX+ADT57MtVCVgGCK1nrVQ1xU5ttuocz4vUThN7
qA9FeFUP+AZK+4HLeq/0iAj1w7DSWFkzPNJldQhMk9BJUpW+t2oYuPI6fZIRzVHP
EdVWe79VBt1UufgM4CL2x0vPyT4HJVTG/6spyjSmXzqz+X9bz0g5ZiKMLmhZ0ovd
R6+3RIPgmTlIeYVRrCv8/G8U2ikL+hSXDVOv1EkUHe1aHGupcLSqR3zyBrIcvg15
esqiTHT3OADbfsTaJJ7s9KENv4j8RGHue+/662sFkVipIjEGyQG4kvBBHC+DI32Q
f65A0u66fBv+y8IfnuAs9fLQ6vQbVA0ZqWJwGZQ1es1EpynHDBqRT4N1c8ORwdYk
EwOHuwTnB6Y4oT6+Pq4wKAmvk4Mlgv7Oy6oxUV86A+1iOSAORC9R0BSq3cn55zsz
41fsBC+7H8a7KyjvzzCzkWyvErSKLAYJASSzm11utsB7oqGYpbPEJ4gIyYKq4P4f
WMrE
=xvfu
-----END PGP SIGNATURE-----

--8QbrEHPJk2J0okaA6Bqlcyd50eMGtBqxg--
