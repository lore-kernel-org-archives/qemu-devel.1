Received: from eggs.gnu.org ([2001:4830:134:3::10]:35371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dRuxb-0004ok-O2
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 02:35:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dRuxa-0001bk-PI
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 02:35:51 -0400
Date: Mon, 3 Jul 2017 16:35:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170703063537.GS13989@umbus.fritz.box>
References: <20170620015332.13874-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ctZH5Gqgrl5HoVnD"
Content-Disposition: inline
In-Reply-To: <20170620015332.13874-1-david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [PATCH 0/5] spapr: DRC cleanups (part V)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com
Cc: bharata@linux.vnet.ibm.com, sursingh@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--ctZH5Gqgrl5HoVnD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2017 at 09:53:27AM +0800, David Gibson wrote:
> This fifth set of cleanups to the DRC code mostly deals with removing
> unnecessary differences between different cases on the various hot
> plug and unplug paths.

With the assorted R-bs accumulated, I've merged this batch into
ppc-for-2.10.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ctZH5Gqgrl5HoVnD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZWeW5AAoJEGw4ysog2bOSrC4QALISbohyPB5xf3ecOzdpEspw
YBE/0KePQj0OkX/1AxDe4TpYviPJvL6Tcx73TKEzue90ZxiksrmOVUfMkP/RN6Pt
QvCRbPPBcqQ/JZBdg2n+VDacR9V43AITh/XFu1znnxuHBnrf40/rSoF4J5MvBYh5
xfilZ5w38GQvQ+nP29bXUYs3pRwlAgxnWPiBwquOYytG1dD2ftP/8VT7rE0O3qYH
iyPyfzLTOkh/HfTx2ZBAMB5gZ08XOceyLBOpVsl6J5qFM4bMJK5q1epfs621rdJz
Hs+O8aMjRBwXURUrGe3tPT3RvQ4IXWR7DyfN/mFg8J2jStzR3SeBGZR6t0hWHrat
y9C7bl0bUQ3Acfvk7wvoC+WlmKWT6KKDliWpWGYcil9xp30cQsKPDbevfH/9apOQ
6knY9oV01FjgCd2Am2SrZ79qs3FRB9AMJPcQA//wVeGeKX4a4BekYcETTkvvTrms
36GsnsJ1e4ux1wOQgMjsw5jt22sC/ArRK8II12tYKn3XA6QBoGWz+1BR7MvpPnbe
OuJWW9OSiJoKT3zAWzDpBYnjPnaby/fDH9+c3LjpZrHgeMoxfghC2oxS3pMLCu50
ni+0fk4byjZ7xl+YjHNyaqyBLXPMg2z6c2jZnEsAWmcDAZ9gb4eJ0JUNc52NWc7r
JkC/IPCj4+KNlAKytEc0
=ezHp
-----END PGP SIGNATURE-----

--ctZH5Gqgrl5HoVnD--
