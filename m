Received: from eggs.gnu.org ([2001:4830:134:3::10]:46624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0Oi2-0006KG-K8
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 05:14:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0Oi1-0000LY-Ln
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 05:14:18 -0400
Date: Fri, 6 Oct 2017 20:12:02 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171006091202.GG10961@umbus.fritz.box>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-5-git-send-email-imammedo@redhat.com>
	<20171006030256.GF3260@umbus.fritz.box>
	<20171006102738.06b23f3f@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z9ECzHErBrwFF8sy"
Content-Disposition: inline
In-Reply-To: <20171006102738.06b23f3f@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/23] ppc: mpc8544ds/e500plat: use generic
 cpu_model parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>


--z9ECzHErBrwFF8sy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2017 at 10:27:38AM +0200, Igor Mammedov wrote:
> On Fri, 6 Oct 2017 14:02:56 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Oct 05, 2017 at 06:24:31PM +0200, Igor Mammedov wrote:
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com> =20
> >=20
> > Acked-by: David Gibson <david@gibson.dropbear.id.au>
> >=20
> > Do you want me to queue the ppc patches here, or do you already have a
> > plan for that?
> Id didn't want to distract others with only PPC related code so
> I've posted this series separately for you to merge it via PPC tree

Ok.  I'm happy to do that, but I have queries on a few patches, so at
this point I'm anticipating a respin.

Just to be clear, you're intending for me to take the whole series?
Or just the patches within the ppc code?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--z9ECzHErBrwFF8sy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnXSOIACgkQbDjKyiDZ
s5K8qQ//VBJg1G+ECfN2ZbWuI9hpMF4tZ45TmLfLCHRbzhcnMQR75FCjtXal+Z0/
B6QTM36cv58Fa+vqIwSJf6qG4FytggUqyGXOa5SjuNgxBt+z5OJN6noy3jItqVmi
I5AOWNj3Bw2v/exbdKKsIVSlSBJcA5wfCMXjDl6XGIYomH/ue151ja+FOgaLuMlE
ONlZ4m0RsEQOQXGfhwDNMs8Aa28VzRMZZ5KxzkksZAudZvBkqZs281m3o1TmKEKg
5xHW6c+uHANrYSzXYMO70JoqCNbNzl8+0i83y69Ok0WwsSp/7GIj/KBn/TnoVa37
vf5t05ydfHvVDCv7URQVQGfSCASS71oxL8MRnCirQewq680+5V9W/VMS1EH4M4p9
BeMOJI24xcZshh7Xn6VgdS1iAY29QMN2lqjoCMFOlwnPX2QFHri2DVf0ab9lBn6F
mUtD/+9AG1jAmvNK5Zt/v7BIbSYITFJesnn0gKfOdCjcL7hFzx1z1/Wg+0os56b2
/SdKKk1fkEG4PJp6ax7FyESSkBtYJZpEtVAbcbfu8oW1zN+uL4qbIBEaVodg1QUT
JtBGICSAZyhjbd4+gQrroaFZlFtfMT8mPWCVDn5GARaq88rIXEA371CQvAMKZBIa
/lgBPs7HgQUOnrMdZEXTMw5UBWEuJwriqDj13me9UJsNjnfd3wY=
=apro
-----END PGP SIGNATURE-----

--z9ECzHErBrwFF8sy--
