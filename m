Received: from eggs.gnu.org ([2001:4830:134:3::10]:39540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecI5E-0001oe-ST
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 16:50:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecI59-0007A2-Tu
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 16:50:52 -0500
Received: from mail-qt0-x22f.google.com ([2607:f8b0:400d:c0d::22f]:33533)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecI59-00079q-OO
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 16:50:47 -0500
Received: by mail-qt0-x22f.google.com with SMTP id e2so34080920qti.0
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 13:50:47 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180118204058.5768-1-f4bug@amsat.org>
	<20180118204058.5768-12-f4bug@amsat.org>
	<b0f29164-f168-0df2-6a9d-399de14ff2c6@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3c6a6247-5c49-0361-26d7-2d7263a51f8b@amsat.org>
Date: Thu, 18 Jan 2018 18:50:39 -0300
MIME-Version: 1.0
In-Reply-To: <b0f29164-f168-0df2-6a9d-399de14ff2c6@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="7OI6jeuunn674a893VEGHOjx4XbJVrUhG"
Subject: Re: [Qemu-devel] [PATCH v7 11/14] sdhci: implement the Host Control
 2 register for the tunning sequence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-devel@nongnu.org, Sai Pavan Boddu <saipava@xilinx.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7OI6jeuunn674a893VEGHOjx4XbJVrUhG
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Eric Blake <eblake@redhat.com>,
 Alistair Francis <alistair.francis@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-devel@nongnu.org,
 Sai Pavan Boddu <saipava@xilinx.com>
Message-ID: <3c6a6247-5c49-0361-26d7-2d7263a51f8b@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v7 11/14] sdhci: implement the Host Control 2
 register for the tunning sequence
References: <20180118204058.5768-1-f4bug@amsat.org>
 <20180118204058.5768-12-f4bug@amsat.org>
 <b0f29164-f168-0df2-6a9d-399de14ff2c6@redhat.com>
In-Reply-To: <b0f29164-f168-0df2-6a9d-399de14ff2c6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/18/2018 06:40 PM, Eric Blake wrote:
> On 01/18/2018 02:40 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> [based on a patch from Alistair Francis <alistair.francis@xilinx.com>
>>  from qemu/xilinx tag xilinx-v2015.2]
>=20
> In the subject, did you mean s/tunning/tuning/?

I did the same mistake in the cover too :S

Thanks to correct this,

Phil.


--7OI6jeuunn674a893VEGHOjx4XbJVrUhG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlphFq8ACgkQ4+MsLN6t
wN7FOA//TNJiHqXJLRLQL1QBCw4plFfqZA8KmyyezLdL/YWEsTcby5c3YmSUeAxd
3Imrd2nsAAL9t2rVptUsNxEbihrHW3nBk3E3X1aErOygDx/6x0TduJQ42H0aa7qd
QFIu0DKMpX8bdeXPodsKdN5M3Lz+wBC9StDii5vA7r32ql/9jCcs1kEOpAU5hK0R
nzPM3MZBEOCh8D9ozoLGV6FSYbXU+dWgHBb0gCzFp2stywJtrUF+DjfdwkLfrDwS
7YYb+5EY1UseHnBJQkj5vnR7Yg9+niUly1C6t79Xwmebel87K94EebFMqGh56Ch3
7sgTuRN9x6b1ou6G6ge5nCf9Hv3xFaqzuTh73vmbqymvc9sH/4DM0+S/M1/CBSi6
+5Z+PYA2yiuoeL/gG661INlZw2XN7gehZ0OruvBPwJvjzaCZyM99Mgxaz9T02rm5
40smMQjlzCPfhEFHcrtItGtqIZoqbt+LxppNomnRtU1mPLjPeoHk0jzgMBb9PIav
pSLAe3v1+RTN5+aokm+jDOuRQYMgdL9OxxTSFB41Za6ql2ruziVNzvVHNmMbUdTf
dS4HxzZlQvzjNima6qeZLOxzJiSaV9mm/1CwNNTC1qF+v/cA27/+UNlbKzPtAKPM
b+dX4DDPWltes0Zn3C3ZJBI+7hj3x52+fAAGv4uVu5m8qci4FaU=
=lSEh
-----END PGP SIGNATURE-----

--7OI6jeuunn674a893VEGHOjx4XbJVrUhG--
