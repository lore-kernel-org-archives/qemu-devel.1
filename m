Received: from eggs.gnu.org ([209.51.188.92]:53123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hEplf-0005Nr-A7
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 02:34:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hEplb-0000rA-J9
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 02:34:30 -0400
Date: Fri, 12 Apr 2019 15:55:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190412055512.GB8005@umbus.fritz.box>
References: <20190411102025.22559-1-cohuck@redhat.com>
	<20190411212405.407918b8@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
In-Reply-To: <20190411212405.407918b8@bahia.lan>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH for-4.1] hw: add compat machines
 for 4.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 09:24:05PM +0200, Greg Kurz wrote:
> On Thu, 11 Apr 2019 12:20:25 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
>=20
> > Add 4.1 machine types for arm/i440fx/q35/s390x/spapr.
> >=20
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >=20
>=20
> For spapr part:
>=20
> Acked-by: Greg Kurz <groug@kaod.org>

and

Acked-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlywKD4ACgkQbDjKyiDZ
s5IC8Q/+MMOIOiDJkyqN1x+qrWTjqUigmYmOrDKEZQYUmjpqTMQWn328JHBhYU/c
BCC2mrGljioeOo4vzkF+2J+aJuy5eeX/+JIH4AUnuuEUT+kG5DnUvVWO5PVoW4vG
fTAZ8vQs6LIJ9enqTbqepkNwfC58u0LwmUPO5pjYZKMrLNgL+x035r3FNX8gkNOj
0xlUm541BDxxYfznTNEePvgHYaA8sI0PbCzu8PTcOO/4TUTzTFQTu2ZBbYBL5qCI
S6MGs3aCdehGHda4B/0OnsyTDhgjLFhE37bRpqd4Us9Oicsy18WXEok9GkiD7/CS
unjL3wkTyiHVCtVLpPASm8MmnIdE4zIBGho2NBzADB4K5Tm+uJTrTmf2Vj+7BpYF
VdoLyZvyP6vjOpQSia8ixLnx3zgL914/3XInKo9Nr8RIi5C7WNbCx41PF9dwUWJ8
1PDaPXiud0YZV+6bd7A8OHmZab6AXKxCJXTZQLsGW9gCFIkopVG02Bz8FqOgjOGl
eW5v/VDNPBSPgkGWxn88fekHdrgckZs3IQpBYfGMtKQJASQnulEGjOKthIDwEWqJ
eb60nA1ExQMyDj7z0ds3v1bVrsHdhJCJG0U1eE2xruSj7yEku6O16AH/S+QzXA6y
X9yZN6nWZSBAkz0pNqRX0Vp3zf4i6d2UWrk1x96Ue+X/gYC2Vew=
=3SX5
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
