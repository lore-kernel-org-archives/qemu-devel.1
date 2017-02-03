Received: from eggs.gnu.org ([2001:4830:134:3::10]:49055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cZf8B-00034x-09
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 09:46:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cZf86-000671-2b
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 09:46:31 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:35785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cZf85-00066t-R8
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 09:46:25 -0500
Received: by mail-wm0-x235.google.com with SMTP id b65so32371228wmf.0
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 06:46:25 -0800 (PST)
Date: Fri, 3 Feb 2017 14:46:15 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170203144615.GD642@stefanha-x1.localdomain>
References: <24f4e37d0c554e379d13a13026efb36f@ex13-live-mbn2.ad.kent.ac.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jCrbxBqMcLqd4mOl"
Content-Disposition: inline
In-Reply-To: <24f4e37d0c554e379d13a13026efb36f@ex13-live-mbn2.ad.kent.ac.uk>
Subject: Re: [Qemu-devel] TCG semantics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "E.Robbins" <er209@kent.ac.uk>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


--jCrbxBqMcLqd4mOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 02, 2017 at 12:09:02PM +0000, E.Robbins wrote:
> I having been looking for prior work on a formalised semantics for the TC=
G language. I have seen passing references, and wondered if anyone can prov=
ide any pointers?
>=20
> If this is the wrong list for this question, apologies, please direct me =
elsewhere.

This is the right list.  Welcome!

Have you seen tcg/README?  It describes the TCG ops.

If it's out of date or missing information, then improving the document
seems worthwhile.

--jCrbxBqMcLqd4mOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYlJe3AAoJEJykq7OBq3PI5awH/iwU5qC+/5MKs+XXCt5UWW3W
5x/C2kuRRGUf0a44oABWAmyZTfKKCht2foJkQixn4Ke+8me6B+SrUgam2gvNriq8
0KsWb9WqF6iqaC2RLvWk5O4uV+GBVp50s9KTbS1RPUcdONB+4VPDjLhJYSCoy7Vf
DSZqRXY4/0hTBM2yjY4Dtwl3Mv3sbLvi9zwbQdQ5913I2jiorG+iozCF8V3NUpcT
igpPvWmanu1C70aOd7CmvGtNiInMMF3s8j6mtf86592nbniFbclX4Ate8F0H6Mid
wuAAPSeRsOv/cf68ZNnfniSFq6Ca8yJPfGYhlWA7JQwUgLJjbaihQ6u76bL0Wnw=
=3q2k
-----END PGP SIGNATURE-----

--jCrbxBqMcLqd4mOl--
