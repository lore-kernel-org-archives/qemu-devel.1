Received: from eggs.gnu.org ([2001:4830:134:3::10]:52084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dMWLf-0000sx-LF
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 05:18:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dMWLc-0002hu-GR
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 05:18:23 -0400
Date: Sun, 18 Jun 2017 17:04:48 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170618090448.GB22449@umbus>
References: <201706051722.v55HMrD0024174@linux03a.ddci.com>
	<OF9DCCDCC7.1E15B7C2-ON86258141.005A829A-86258141.005ABB35@ddci.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
In-Reply-To: <OF9DCCDCC7.1E15B7C2-ON86258141.005A829A-86258141.005ABB35@ddci.com>
Subject: Re: [Qemu-devel] [PATCH v3] target-ppc: Enable open-pic timers to
 count and generate interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alarson@ddci.com
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2017 at 11:31:02AM -0500, alarson@ddci.com wrote:
> Aaron Larson <alarson@ddci.com> wrote on 06/05/2017 12:22:53 PM:
>=20
> > From: Aaron Larson <alarson@ddci.com>
> > To: agraf@suse.de, alarson@ddci.com, david@gibson.dropbear.id.au,=20
> qemu-devel@nongnu.org, qemu-ppc@nongnu.org
> > Date: 06/05/2017 12:22 PM
> > Subject: [PATCH v3] target-ppc: Enable open-pic timers to count and=20
> generate interrupts
> >=20
> > Previously QEMU open-pic implemented the 4 open-pic timers including
> > all timer registers, but the timers did not "count" or generate any
> > interrupts.  The patch makes the timers both count and generate
> > interrupts.  The timer clock frequency is fixed at 25MHZ.
>=20
>=20
> I haven't received any feedback on this patch, and I don't see a response=
=20
> on the mailing list archive.  Did it get lost?

No, I've just been busy and then sick.  I'll get to it eventually..

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZRkItAAoJEGw4ysog2bOSb7sQAOPkLERv6jg1/OgKH1FNUUto
uxZlT2ipz/JLT9qCAk9XP6j7/j6cI1kygJbhfmmQLVQ/HkPuCURxl1UIel/OgWik
JTSvOHzK39rpnlcE++v9t114JLYWxpxEAjYjgq3uk7wZDETw3IYbKnCdwqoLwuRo
h/uisYpOYFKs2TDACy16gWHUAMvhcmAmnJeZ4ciDASdz/Xm0rWUhoX9DwOWYhsNM
uTEOaafQVmV7Cs+qR77j3XS+4JUr3ZpF9Y+x/KShYJvGMnl2mdPIRujeqJf2qfDR
g9yd49nOnkCPe5PC2GOz0TCt8BVxbCKnDNdKCpbhQ/dzYR+6WAMYDsgWjqEMwE0G
HUdNwgifxd7ysNWLG2riHqm0SaJvvlcPBLQirUWcRkrYk3X0rbeDLgvM6hLocDFt
JT9qfgCvN5yKCmPwIj9rinDPj29zdZookuQF4h4XuL07YUcR9gOmZxgMndfzMnzB
Bvc6wBBxb64bURZVcZt36QBsj34ON0H2m5zI6kqYYMkW/YunXxYbNf1kfSFg7SBX
rM6G7bcBXCmjgydYSjygLIMgLxWwnb5x7Fzjb6Rg/8byagkBOINGsdFG5r4CGGF2
m35ASo5OO3CzCdoltBTHkWqJWZj8TCn776B0uqag+3OEtlLqvY8tuu6EckGeaeK1
/znwRElq45Jo4/5L6uE4
=64A6
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
