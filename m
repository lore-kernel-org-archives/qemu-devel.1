Received: from eggs.gnu.org ([2001:4830:134:3::10]:58963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6epq-0002Rb-VY
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:08:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6epm-0003VE-Vw
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:07:59 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d6epm-0003Ur-P5
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:07:54 -0400
Received: by mail-wm0-x244.google.com with SMTP id u65so1894386wmu.3
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 08:07:54 -0700 (PDT)
Date: Fri, 5 May 2017 16:07:51 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170505150751.GD14316@stefanha-x1.localdomain>
References: <1618105799.2706822.1493821255206.ref@mail.yahoo.com>
	<1618105799.2706822.1493821255206@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Km1U/tdNT/EmXiR1"
Content-Disposition: inline
In-Reply-To: <1618105799.2706822.1493821255206@mail.yahoo.com>
Subject: Re: [Qemu-devel] Dummy Panel.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Bradley <flypie1@yahoo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, John Bradley <flypie@rocketmail.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>


--Km1U/tdNT/EmXiR1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 03, 2017 at 02:20:55PM +0000, John Bradley via Qemu-devel wrote:
> Hi
> I have created a new fork on GitHub https://github.com/flypie/flypie-pi-q=
emu and an associated project https://github.com/flypie/GDummyPanel the ide=
a as well as getting the Original PI emulation working is to add some facil=
ity for simulated IO. This is a demonstration of the latest version, runnin=
g the QEMU demo from https://github.com/rsta2/circle. I took the idea from =
an implementation for the BIFFboard but only the socket number is left, the=
 commuications is all via IP. The code is only really Alpha level at the mo=
ment and needs some refing to reduce bandwidth. I could also extend the cod=
e so that the connection can be to a remote machine rather than via the loc=
al host.
>=20
> I intend to generalise the code, to work with several different boards ot=
her than the PI, could anyone suggest a board that would benefit from such =
an add on.
> Is this a worth while addon?=20
> John BradleyTel: 07896 839635Skype: flypie125 125B Grove StreetEdge Hill =
Liverpool L7 7AF

CCing ARM maintainers (see the ./MAINTAINERS file to find the right
people to CC)

Stefan

--Km1U/tdNT/EmXiR1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZDJVHAAoJEJykq7OBq3PI2dIH/jYDyMAPKcsCT1mT29Fcn6oq
zYw2IWLk8hHbGGJJalL6Rh/aER5NDqDBW1qYmmI90cdU3giSuIaz+WRTVGVZJbmt
/+gtWvvIB6pPDFlFYdMMnaIbNe6iyu4lZfKiLo8Hlqaxt0i72SAfqjEHoV74kMNk
Q0TWkRbyKjVXSNESH8ygANBLFeRmdSqxSN3ZQnS1Aq1ZoIGAdTT2CQETSUhs9hoG
SHlwH+InQNyagRN8sDs+9c/42VTRUqage/HRVKdGOIIoBZzSGtuOw6/Wv4R3ztu8
7DZdY0UzIK42okFuXxthLoDloG98TMSV1F2vuJKoAwv245JQQR/o2m/n03QbZ/g=
=NxpQ
-----END PGP SIGNATURE-----

--Km1U/tdNT/EmXiR1--
