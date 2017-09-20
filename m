Received: from eggs.gnu.org ([2001:4830:134:3::10]:54661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duYCq-0007cn-TL
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:09:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duYCm-0003vd-M4
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:09:56 -0400
Date: Wed, 20 Sep 2017 16:00:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170920060014.GI5520@umbus.fritz.box>
References: <1505851374-6408-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170920042907.GC5520@umbus.fritz.box>
	<88f39fd3-0ecf-8c37-e159-684c845672fd@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D6z0c4W1rkZNF4Vu"
Content-Disposition: inline
In-Reply-To: <88f39fd3-0ecf-8c37-e159-684c845672fd@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCHv2] macio: convert pmac_ide_ops from old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--D6z0c4W1rkZNF4Vu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2017 at 06:56:37AM +0100, Mark Cave-Ayland wrote:
> On 20/09/17 05:29, David Gibson wrote:
>=20
> > On Tue, Sep 19, 2017 at 09:02:54PM +0100, Mark Cave-Ayland wrote:
> >> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> >=20
> > This didn't apply for me.  Can you rebase on top of ppc-for-2.11, pleas=
e.
>=20
> (goes and looks)
>=20
> Okay looks like the issue is that you're missing "[PATCH 3/8]
> ppc/ide/macio: Add missing registers" from your queue - I see you
> replied with an applied to ppc-2.11 email so I bet this got dropped on
> rebase somewhere.

Oh, sorry.  Not sure how that happened.

> Can you try again with that patch added and then let me know if it still
> doesn't work?

Uh.. I've lost track of it, I'm afraid.  Can you resend it and the
ide_ops one as a series.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--D6z0c4W1rkZNF4Vu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnCA+UACgkQbDjKyiDZ
s5LXQw/+IUdX0Xje27zZUdnIOIqh72hS94pbZwF1r8652d6P99mZsg9OQ3Dld+/r
dLiCo99Bp9Lt+1Mh6VTroutx+VJW49Bn4AyJsapXaHmjddccJSOsVAknz2R0Mxrg
MvO+rs2M5rJV/HlEJPmMe6AZ5cu7jax4JM5kHqu9MZ5703mnFFmqLIgd6tdv5SRq
PaqdZOz7fmPq8OYo2o9PwBDYIaIF9nEQVWC4gptfC499WYnos3Fo//Mohrzrd4kl
RqKotQyFNKaEAgR2/ruXqmLBq//rEDw1PoVVswPQHcKm1UDAY3gbV8AZZxAGy+2k
OTmnHBujDjinvZSKGpWAVt8j/JGfJTBFf/mgA0usJ3uCrvqHaniHWiiCy+oEBb+F
WdNbc5o8JoI9V7uTzRFdilKmviNUcOB0YkDdTkyHCl+bXUGtoarjED0e8e9UXgfw
xj4lBUKXKXbIR6t6HVwLA0jjvHce9OuVJtBCashzP2Q3pVzf25LldwrxUy17/cta
iPf2SQmlCeYLldSw3MM5VygwhQ2Zu2Q6q5HkMj5o4aN+xXohMRnejqNkvy/nhIkm
DAr4fGYwGO8S3f0PuPiN14HaBy+O9orVAVn1koqk9PDasxFPup8YvaCB/isuXcCT
tbx7jPqgc7NwM5kuGSYiaqE9U7Nq1h1QWess5T01Rk46F7zHs3U=
=xpp4
-----END PGP SIGNATURE-----

--D6z0c4W1rkZNF4Vu--
