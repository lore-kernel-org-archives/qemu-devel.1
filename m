Received: from eggs.gnu.org ([2001:4830:134:3::10]:60115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eYtGE-0007P7-Dg
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:44:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eYtGB-0006IT-9N
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:44:10 -0500
Date: Tue, 9 Jan 2018 23:16:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180109121653.GN2131@umbus.fritz.box>
References: <20180108055348.20444-1-david@gibson.dropbear.id.au>
	<CAFEAcA_vmTqHdjL6QfKtn-Khg2RHBA7Vs3QxreXwe2J_7mhGAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XLsjFikA86nwwlhe"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_vmTqHdjL6QfKtn-Khg2RHBA7Vs3QxreXwe2J_7mhGAQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/12] ppc-for-2.12 queue 20180108
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: surajjs@au1.ibm.com, Greg Kurz <groug@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>


--XLsjFikA86nwwlhe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2018 at 11:46:41AM +0000, Peter Maydell wrote:
> On 8 January 2018 at 05:53, David Gibson <david@gibson.dropbear.id.au> wr=
ote:
> > The following changes since commit 281f327487c9c9b1599f93c589a408bbf4a6=
51b8:
> >
> >   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.12-pull-=
request' into staging (2017-12-22 00:11:36 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180108
> >
> > for you to fetch changes up to 9f173585d3f35345b2facce50620ce2cdda05f2f:
> >
> >   spapr: Correct compatibility mode setting for hotplugged CPUs (2018-0=
1-08 13:33:17 +1100)
> >
> > ----------------------------------------------------------------
> > ppc patch queue 2018-01-08
> >
> > This pull requests supersedes both ppc-for-2.12-20180103 and
> > ppc-for-2.12-20171219.  We've discovered that some substantial
> > extensions to the proposed capabilities infrastructure will be
> > valuable, amongst other things for managing/advertising workarounds
> > for the dreaded Meltdown/Spectre bugs.
> >
> > Although that could be done as follow on changes, since the caps
> > infrastructure hasn't been merged yet, we might as well pull it out
> > while we rework, and just merge the unrelated bugfixes.
> >
> > The last two pull requests apparently had problems on some arm32
> > systems.  I haven't been able to reproduce those, so I have no idea
> > which patch is causing them.  If we get lucky and it was one of the
> > patches I've removed from this series, this may also serve to unjam
> > the other fixes.
>=20
> This still hangs on my arm32 setup in the migration test. I'll see
> if I can identify what is going wrong.

Thanks.  Even if you can identify which patch it is and we can
postpone that one would be a bug help.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XLsjFikA86nwwlhe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpUsrIACgkQbDjKyiDZ
s5KaNxAAlBm/FBqwGPK2zuD7MJHNEP9C3JdFzXsq2VWp3qm+F6eqQsHKyXAS+anw
crMmiFQQFlklPzv8o1z4LL17c70ycofxAm4kwC2/zURbrJyxThN4Gc6o4zmp0SBv
3LugW1xvxJnxIMhPil2xgZQ1D3ouxIcc+KxYvSxgIgsoK2PyU5Y0EJJfg3VVrjEO
DP9UGrwpZFzHJXMvdsG/LKC7X36EuiUgkq0zzUUb8ZoxOjQkIIAxcfLOSHlaR5a7
t6T6HuB0NkW7NRey5iAjzZfZdMYWd28eqp3V10JE2JQVK/2cdbvu4AWZvs0uvMnC
tQM5oRhLPLUvu1wjbaYc/sqsNqS2WlrlQBzLLHiLdIqL4LUp4Fjd+8r71UU/EY5Z
el+ztBk3qWjyKY9uFHBa9gyHQHAiR8MdztgkCfQdnmruOzqzdQw1xL92PxJFzdOV
uB8QIM3qWP052McdzD6Yr6z8keGU+EWQfTiX0VQkZrQufDfOxl+hxAOzna4YtHGt
jcsa1GJyzc1peD8QPvc7Vo4dne2w9obyEYbjF9RD83hn1GWMQ01nmWMZWCAMnId8
zwMEb0Q0RvNnJ5NZHyxBKTwApZ/YXm41f3evgP2MJ3WUDuWUlZOHFRiSbQJ1YSqz
Tav4Ta5KM8m7p0wz0awYr1qbZiXlzVU2p/stuGURJTzgu4aDi3c=
=Xa6t
-----END PGP SIGNATURE-----

--XLsjFikA86nwwlhe--
