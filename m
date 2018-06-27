Received: from eggs.gnu.org ([2001:4830:134:3::10]:56799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fY724-0008Pa-1B
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 05:46:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fY723-0004uv-5S
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 05:46:36 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34199)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fY722-0004t7-Uk
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 05:46:35 -0400
Received: by mail-wm0-x243.google.com with SMTP id l15-v6so17528445wmc.1
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 02:46:34 -0700 (PDT)
Date: Wed, 27 Jun 2018 10:46:32 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180627094632.GC4325@stefanha-x1.localdomain>
References: <20180627073351.856-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p2kqVDKq5asng8Dg"
Content-Disposition: inline
In-Reply-To: <20180627073351.856-1-contrib@steffen-goertz.de>
Subject: Re: [Qemu-devel] [RFC 0/8] arm: Changes to Microbit Board and NRF51
 SOC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>


--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 27, 2018 at 09:33:43AM +0200, Steffen G=F6rtz wrote:
> This is a series of changes to the NRF51 SOC and the microbit board.
> The changes can not be posted as patches as the nrf51 is not mergable
> yet due to missing cortex-m0/armv6 support.
>=20
> "arm: Add NRF51 random number generator peripheral" was already
> posted to devel and is being discussed in <20180626104943.2756-1-contrib@=
steffen-goertz.de>
>=20
> "arm: Add NRF51 SOC non-volatile memory controller" was already=20
> posted to devel and is being discussed in
> <20180626093204.27612-1-contrib@steffen-goertz.de>

Which tree does this series apply to?

--p2kqVDKq5asng8Dg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbM1z4AAoJEJykq7OBq3PIlbEH/2SOi1tTAdIbe0/4IHeIwbuM
jIgjax622n1cOfh8BxxAFCqunpNL4BS4a3XbvaSBVMqMFmlL9NV4xBqGgxLfg7NL
AmVA4RENYNM/rwrWGUxi2K9VlkSDcYLhlga0vzxwdY2HP3q0l6PiRpke5O1jOFB5
Rar04/sxS12lhyIIzmsxSA+sNpiKTLSjPfqDD2c56l2SfRVHf8jNO1So49yDwWNz
4ErkEsC9HQ75Krp95LfKJI85lgYQwKtJM3z1zl/RDm+wVRYaFHWDi4c5mSbvUE4S
g6/3U14adnMj4mXEecaemAJS4DICz/snC2wqEdxvl5DVQG5nZZ6ozP6eOdos9qY=
=XxdK
-----END PGP SIGNATURE-----

--p2kqVDKq5asng8Dg--
