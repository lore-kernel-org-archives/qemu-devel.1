Received: from eggs.gnu.org ([2001:4830:134:3::10]:44212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYjBN-0003xT-55
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 19:53:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYjBK-0007Ui-30
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 19:53:57 -0500
Date: Wed, 1 Feb 2017 11:19:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170201001932.GC30639@umbus.fritz.box>
References: <20170126101600.16348-1-caliborn@sdf.lonestar.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ABTtc+pdwF7KHXCz"
Content-Disposition: inline
In-Reply-To: <20170126101600.16348-1-caliborn@sdf.lonestar.org>
Subject: Re: [Qemu-devel] [PATCH v2.1] target-ppc: Add MMU model check for
 booke machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Valentin Plotkin <caliborn@sdf.lonestar.org>
Cc: qemu-devel@nongnu.org, Valentin Plotkin <caliborn@sdf.org>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alexander Graf <agraf@suse.de>, Scott Wood <scottwood@freescale.com>, qemu-ppc@nongnu.org


--ABTtc+pdwF7KHXCz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 26, 2017 at 10:15:59AM +0000, Valentin Plotkin wrote:
> From: Valentin Plotkin <caliborn@sdf.org>
>=20
> Machines bamboo, e500 and virtex-ml507 assume a certain MMU model,
> otherwise resulting in unpredictable behavior. Add apropriate checks
> into *_init functions.
>=20
> Signed-off-by: Valentin Plotkin <caliborn@sdf.org>

Applied to ppc-for-2.9.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ABTtc+pdwF7KHXCz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYkSmUAAoJEGw4ysog2bOSan0P/1i20osA1BehprtdwW58O/J7
LciNgX/Y2br/IEIa9EaW6npWhXCwMa3Qtnc9/kM43Cg20tkbLhEYyWfN2uGQA/gN
KFenz5XxhI0rjb21uWLSZDHSFfwqxiwwRIs8+Dh+Tz7J7A692t7hXoe6aGaHYJue
7tiTH6MPu4BKZoElzB1qm7BLrUFGJd6fR60Ny8oW6wWcWsNQAmQdpMuqOK0TtheJ
LetLMcerRaRBLhqf5ZZ8azY+jdEvSrKwRNA68NmNUB6qsNsHIxNNWh1TQZw20XVD
OK0D51oC4K6BZ/D3wXV7dsOriOgBGqiZrPUmZJ2XMg/9qu5cnqW/eYLCEzKEaJwZ
FJT7PE9d7mo/tBmYQmwnV3GEjHTZgCoonbHKAiZWE6ivUwDIeOXdVBaHnDgduBHZ
aUP0GATsHa+BJzockF7MjFav4jhqrwnhzDwep8sULnNcJHlLH1hkt1tu+nBaK9KM
78GHSL+NyP+CniSNu/rY0o4nSxZhO16BU6pEwE9SLKt4X2JVDYqJp3ahkrl/gi3U
ySeetJbxW6NSdCusmJ80mCKItVgOWU4r+LiObavK320Wwj2i4c+ARPcCTkV46IJy
1lOyRUUMbOjwOukJ5Yw29dtzbs+kSdOBiW1Ky4nH93p/P9CnMleHovJWbPtZZOHa
F1aiU7b5FL3jwNS7AvsT
=FRRE
-----END PGP SIGNATURE-----

--ABTtc+pdwF7KHXCz--
