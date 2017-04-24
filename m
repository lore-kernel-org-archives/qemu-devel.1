Received: from eggs.gnu.org ([2001:4830:134:3::10]:47219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d2Zqw-0006ZW-J2
	for Qemu-devel@nongnu.org; Mon, 24 Apr 2017 05:00:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d2Zqs-0007bZ-BD
	for Qemu-devel@nongnu.org; Mon, 24 Apr 2017 05:00:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1d2Zqs-0007b1-44
	for Qemu-devel@nongnu.org; Mon, 24 Apr 2017 05:00:10 -0400
References: <6e650412-7a28-f924-4405-de1640505dfb@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5e1a97a6-00ec-d429-b754-49b86edcb076@redhat.com>
Date: Mon, 24 Apr 2017 10:59:58 +0200
MIME-Version: 1.0
In-Reply-To: <6e650412-7a28-f924-4405-de1640505dfb@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="6peXKd5a05vFo4LpJ7jAkndhdOiDCx75e"
Subject: Re: [Qemu-devel] ppc MAINTAINERS update needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6peXKd5a05vFo4LpJ7jAkndhdOiDCx75e
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20.04.2017 03:06, Eric Blake wrote:
> The sections for e500, mpc8544ds, and ppce500 all list Scott Wood as a
> co-maintainer, but I'm getting bounce emails for scottwood@freescale.co=
m
> as an unknown address.  What is the appropriate tweak needed to the
> MAINTAINERS file?

Scott sent a patch now:
https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg03474.html

 Thomas



--6peXKd5a05vFo4LpJ7jAkndhdOiDCx75e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJY/b6TAAoJEC7Z13T+cC21wJYP/0rzLyrIGPIhJJhDgNCKUKVr
msDRT0g2z/uWuG0mIP3W8B5DXbXnjZqrbtbb72eT+OI0NvLb3i8E8EPXniqh4BIb
xI4D9gRL3PkdJ+0SR/JRrHvEhRRTli75VS1nbmfikc53muVwFMkedeAUexxLloN2
pz7CieIsKii2T5eMWrIbNiSyEEiIFR8iIyX6I3sHWR4UzWw+ABPU2vtxpgqETG9l
1a7pVMcAjYbWusLdpZgxPsH1589YD9g50WP+28xCzLBeb54ptVOi0rifLs2suk+t
nTXpb18cx8X4V1Nx6yzkd7+mx4BYNJNzTJuo5rcp3KZKJ8VDQ3Xu4RwPElcCdobx
Jn7MCrVG/gL7lKddXp/HJId56KQ0Vj0ZkEDQTtSdWN+3hjnzHjtUOiJt55unN6Yw
Og/r5xyU5sMLUyiB1dSQWqjsCsrjoUlGl9+XEu0hgVjtASGnSZyR7mWoMoNi12ve
jD4GKElzdKfIJIcHxh5R9a1F4B/buKLBvoxwg0mXuA/Ormtt45vWk59cAXxrsiz2
wr0m7VNSpjBl+aLCyd9K13x3hgLOYcpxTdk/AbGu/x3nlwuI82moE9y4CLZ52dbY
GW1mkeIwhTYDg4FbOoyuRD34BSfOc1TDQ5GMfSvlNzCxFJhyGDPiXsdBPukdwbkt
+tjKlYuIFcYFVLelTZgq
=LqX9
-----END PGP SIGNATURE-----

--6peXKd5a05vFo4LpJ7jAkndhdOiDCx75e--
