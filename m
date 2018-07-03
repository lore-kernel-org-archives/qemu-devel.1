Received: from eggs.gnu.org ([2001:4830:134:3::10]:50053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <claunia@claunia.com>) id 1faSxE-0007e5-SM
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:35:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <claunia@claunia.com>) id 1faSxB-0005ba-GJ
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:35:20 -0400
Received: from [107.174.70.112] (port=42944 helo=mail2.claunia.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <claunia@claunia.com>) id 1faSxB-0005ap-8q
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:35:17 -0400
References: <20180630083357.23489-1-huth@tuxfamily.org>
	<bb109e75-6c00-45b2-bb17-7d09ff3a8112@ilande.co.uk>
	<20180630151444.2f0b30cb@thl530.multi.box>
	<CAFEAcA_wo8t2CTRj4oizRPUbG7fa0MgdACpAnLvR53Pp+piLjQ@mail.gmail.com>
	<20180630153422.03f0146f@thl530.multi.box>
	<CAKbio+kqcmD9vba-67wbyPX2Er7=cUP-vH1+FYrFK4ToZf9hCw@mail.gmail.com>
From: Natalia Portillo <claunia@claunia.com>
Message-ID: <038e1df0-7e13-ac6f-4e5e-5a8e41c0f54d@claunia.com>
Date: Tue, 3 Jul 2018 21:58:33 +0100
MIME-Version: 1.0
In-Reply-To: <CAKbio+kqcmD9vba-67wbyPX2Er7=cUP-vH1+FYrFK4ToZf9hCw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QGh1FdRHTaAWtHc309FiRsxaEEc6BiR6r"
Subject: Re: [Qemu-devel] [PATCH v1 0/4] m68k: Add basic support for the
 NeXTcube machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bryce Lanham <blanham@gmail.com>, Thomas Huth <huth@tuxfamily.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QGh1FdRHTaAWtHc309FiRsxaEEc6BiR6r
From: Natalia Portillo <claunia@claunia.com>
To: Bryce Lanham <blanham@gmail.com>, Thomas Huth <huth@tuxfamily.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Message-ID: <038e1df0-7e13-ac6f-4e5e-5a8e41c0f54d@claunia.com>
Subject: Re: [Qemu-devel] [PATCH v1 0/4] m68k: Add basic support for the
 NeXTcube machine
References: <20180630083357.23489-1-huth@tuxfamily.org>
 <bb109e75-6c00-45b2-bb17-7d09ff3a8112@ilande.co.uk>
 <20180630151444.2f0b30cb@thl530.multi.box>
 <CAFEAcA_wo8t2CTRj4oizRPUbG7fa0MgdACpAnLvR53Pp+piLjQ@mail.gmail.com>
 <20180630153422.03f0146f@thl530.multi.box>
 <CAKbio+kqcmD9vba-67wbyPX2Er7=cUP-vH1+FYrFK4ToZf9hCw@mail.gmail.com>
In-Reply-To: <CAKbio+kqcmD9vba-67wbyPX2Er7=cUP-vH1+FYrFK4ToZf9hCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Now you've made me subscribe again to qemu-devel ;)

On 30/06/18 18:07, Bryce Lanham wrote:
> Oh hi!=C2=A0
>=20
> Luckily gmail brought this to the top since I don=E2=80=99t pay attenti=
on to the
> list. I=E2=80=99m away from my computer at the moment, but I had more t=
han this
> working, including interrupts, Ethernet, and SCSI for sure.
> (https://i.imgur.com/Py0FO.png)=C2=A0I=E2=80=99d love to dive back into=
 this now that
> 68040 support is complete and merged.
>=20
>=20
> On Sat, Jun 30, 2018 at 8:34 AM, Thomas Huth <huth@tuxfamily.org
> <mailto:huth@tuxfamily.org>> wrote:
>=20
>     Am Sat, 30 Jun 2018 14:17:32 +0100
>     schrieb Peter Maydell <peter.maydell@linaro.org
>     <mailto:peter.maydell@linaro.org>>:
>=20
>     > On 30 June 2018 at 14:14, Thomas Huth <huth@tuxfamily.org <mailto=
:huth@tuxfamily.org>> wrote:
>     > > Weird... the mail was ca. 1200 lines ... that not small, but no=
t so
>     > > big that I'd expect that it would get blocked somewhere. Let's =
wait
>     > > some more more hours, maybe the spam filter is just very slow
>     > > today. If it is then still not available on the list, I'll try =
to
>     > > send it out again.=C2=A0=20
>     >=20
>     > The mailing list does just occasionally randomly eat patches,
>     > as far as I can tell. It's not purely a size thing.
>=20
>     Ok, good to know. I've just sent out patch 3/4 again, let's see how=
 it
>     goes.
>=20
>     =C2=A0Thomas
>=20
>=20


--QGh1FdRHTaAWtHc309FiRsxaEEc6BiR6r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEI28eIbVA/A1A960XUdIEiMckyp8FAls744IACgkQUdIEiMck
yp9TzQgAwTJJByqJQrk2N2shtlxeRXhibQYjczaYY2UFJZCniJhnz/+Di77a3mQ+
/ePn3h7cxbOMc1HudBG/UWr5Jar+qZfS5tG9TBQkp8PE135Rb1hUvOJYFL5ZzSY0
3WlpskCu7/3Xzv1CYdM7N0N0HST8nkJv9fYEDyOQFOnFR1hZSEgWfujXooHjcBOp
279hEiK1Vd179L6UwgDMR8HX3F1ICd6o3ztI3o3CvsmEyegLBSItvu8hzRBWtkGv
KLhKagn6doGPxzhh3WMmVAxgq+4YouGsPrBuDnIVLA9az0eJeVJUHZxcVYIZNa6/
6js0WzVouNf0ms51JwM6F9cYlTdV+A==
=VJC3
-----END PGP SIGNATURE-----

--QGh1FdRHTaAWtHc309FiRsxaEEc6BiR6r--
