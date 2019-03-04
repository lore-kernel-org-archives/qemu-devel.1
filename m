Received: from eggs.gnu.org ([209.51.188.92]:42207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h0jml-00014k-7j
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 04:21:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h0jmj-0006CT-9n
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 04:21:23 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:43643)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1h0jmb-0005kv-Sh
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 04:21:19 -0500
Date: Mon, 4 Mar 2019 19:38:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190304083806.GA12893@umbus.fritz.box>
References: <CAFEAcA_-wNGz_ftDziARUwzL2Lc+1kkoMTo0OxV4UVwbTr8EaQ@mail.gmail.com>
	<9b211327-06a8-9739-e984-4b05557c12b4@suse.de>
	<20190104050301.GB2801@umbus.fritz.box>
	<CAFEAcA9fyHiKOA7bDr8c_05C6rX_CYdj8nP+xFFSH_4uWbokhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9fyHiKOA7bDr8c_05C6rX_CYdj8nP+xFFSH_4uWbokhQ@mail.gmail.com>
Subject: Re: [Qemu-devel] can we update QEMU's version of u-boot.e500 ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 28, 2019 at 01:23:38PM +0000, Peter Maydell wrote:
> On Fri, 4 Jan 2019 at 05:22, David Gibson <david@gibson.dropbear.id.au> w=
rote:
> >
> > On Fri, Jan 04, 2019 at 12:44:59AM +0100, Alexander Graf wrote:
> > >
> > >
> > > On 03.01.19 18:38, Peter Maydell wrote:
> > > > Hi; currently we ship with a u-boot.e500 which is from u-boot
> > > > v2017.07. It would be nice to move that forward, specifically
> > > > to at least v2017.11, which contains upstream u-boot's part of the
> > > > fix for https://bugs.launchpad.net/qemu/+bug/1714750 .
> > > > (There are more recent releases than that; it's just the first
> > > > that contains the fix.)
> > > >
> > > > Then we could remove the workaround in scripts/make-release and
> > > > close out the bug.
> > > >
> > > > I've cc'd David as the current maintainer of pc-bios/u-boot.e500
> > > > and Alex as the last person who did an update.
> > >
> > > I think it's a great idea to update it.
> > >
> > > David, do you want to do that or rather have me send a patch?
> >
> > Please send a patch.
> >
> > I'm maintainer of all the ppc boards by default, but I really don't
> > know anything much about e500 or u-boot.
>=20
> Hi -- any progress on this ? It would be nice to update the u-boot
> blob before QEMU hits softfreeze for the next release in a
> couple of weeks...

It would.  If there's been another patch, I haven't seen it though.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx84+sACgkQbDjKyiDZ
s5JGfw//YfV9dAtD/r8YpyulgFL7sCO3az4Sfme+zr0zXj42EpaHB+vFWMW3Pl2v
InPCxNfXyAE4qlBhNt2n62U7Kh0bO31GtYnzIVDlIW61UIxw0U4C3iUmR1MfigrN
g1q52O7TLd33rZwmyErQof76ZYNWw7aTa1bcoLah3zqDow6X5tTrsDsmi/3aOrIZ
gKA0tV8C72LGu5GAe/mHt2o0zpFr6aQXnKyMl8R/weyIXwKG1ie9S2vfNU+SUUsv
lQwD1RnkONr9JXhqEfgEMP3DuXSx0WjbrvYQ7n+4zLAdKgkP1hPQtDY2STGWxB2M
9NHK86dgh4ODo70gvLxdU0lNE3UzSJPQA/wl/8/LlsbTOSGrH94a1MSiWgtf13Yt
Ag6rA/NZzOiN77gU4050LJqI78vrgB9RJI0KcOmPp8dEE9sY5HVBj1L4oUHfG3dp
wmYNTV/jUHRMpRMo/G471wE5pfO9g0nWuTbdhocDG0AEmVGDKIrY0bGRu8x5pIzL
DucB/1+e0LF8igGT1x/rr7g69/aZJpEY59G8lkNe98oXaJecXV8KVxDHZzNjTZk6
7h7Ie66OXJxoYLTz99QXU5/l6/Iuni/6xPj+b/No4ngQFyTJglgZxNF886W1KZYY
VaCHcdLbkSvnY7au55QO0YJfCMN507XeIIB4hJHim6+daMk4Vn4=
=L2sb
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
