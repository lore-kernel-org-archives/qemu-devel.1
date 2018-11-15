Received: from eggs.gnu.org ([2001:4830:134:3::10]:48390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gNJLv-0002v8-Un
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 10:14:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gNJLs-00029C-6z
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 10:14:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gNJLq-00027x-8d
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 10:14:40 -0500
Date: Thu, 15 Nov 2018 15:14:33 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181115151433.GA19418@stefanha-x1.localdomain>
References: <1533076661-8030-1-git-send-email-linux@roeck-us.net>
	<CAAdtpL6dAKVj3bBLRS_6x4B3Pmed9hodd6-kh2imBbs81txV8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <CAAdtpL6dAKVj3bBLRS_6x4B3Pmed9hodd6-kh2imBbs81txV8g@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] hw/sd: Mark sd-card as storage device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Guenter Roeck <linux@roeck-us.net>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2018 at 03:24:25PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On Wed, Aug 1, 2018 at 12:37 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > sd-card is currently listed as uncategorized device.
> > Mark it as storage device.
> >
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Do you send pull requests for the SD card subsystem or who will pick up
this patch?

Stefan

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb7Y1ZAAoJEJykq7OBq3PIVdMH/0PF+xCTCTtgKWCecQmrSNYI
RmA2jmErJrsNzU2A+bXPDnvaSYZL5+XXY22qgtAQfgGM816zFmsz2VEfVeAOFlGJ
yW4Kw92Eh5utfLR6OPE3GVRer8roBBp9X8dhBNkAl0ivXAcFvz0RHKPBh7LAPpgS
UX3NecVgLuS/a0Br71/NxiKkXZmjRT4p9qmq/SuJL6LUM1exN+U3magrzYn3bIx4
SKSqZgKjdbIZZp0w+KJ7/IDkgu5mJNjac9autJVQVuvyhBK1vzZNNGckmo83Dr5u
g6v9FW9G6tgLWAS2NbCEsBCcLxYRjaTyMnBwjDObRPz9UdiqUJmkLvkcJj9l70g=
=Z36q
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
