Received: from eggs.gnu.org ([2001:4830:134:3::10]:55980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cE77X-0007ql-Vh
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 23:12:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cE77X-0004N4-1D
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 23:12:47 -0500
Date: Tue, 6 Dec 2016 15:12:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161206041208.GQ32366@umbus.fritz.box>
References: <1480937130-24561-1-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XQ/JOjNzrAcf1KaA"
Content-Disposition: inline
In-Reply-To: <1480937130-24561-1-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH ppc-for-2.9 00/13] POWER9 TCG enablements -
 part9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, rth@twiddle.net, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com


--XQ/JOjNzrAcf1KaA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2016 at 04:55:17PM +0530, Nikunj A Dadhania wrote:
> This series contains 12 new instructions for POWER9 ISA3.0
>      Couple of consolidation patches
>      VSX Vector Insert/Extract Word
>      VSX Vector Permute
>      VSX Load/Store with length
>      VSX Scalar Quad-Precision Move Instructions

I've merged 1, 9 & 10 to ppc-for-2.9.  The rest I've left for now
since they have comments from either me or rth.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XQ/JOjNzrAcf1KaA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYRjqYAAoJEGw4ysog2bOSgbgQAKQUKdwwWlnVzVVhwhDjtoZv
RaNENmp02JYvobudjAXX+9nL1+gsSWxnghehEVtmw2kPIVZAb5aR+a+q+/V2NcHC
BPk9AarRqNMIrEbOX7Rsnc7F42DMci/1BLF1EI4Jlk/wZfbkARK9dh3WtYI0Hrfm
Pbb0ur+3nYNUN75S2AkmevA+7jUAcKseS4STdzy0atFPGD0eHe3PpjX9/fqeuX3X
88XqF9BbIdW2HdW5haRzS7jJvYdSUtdT3taepbw6OeMFARD1Q940hmsK7/7rZFbS
uKPLOa9n1nVfkA7mZU5NPVUzcWn2g/BiAhd3VHaXoFcualunOSChyeB86U6oNvoB
gKA6aMTYwLjDe/2baE3ySyKlwJC+sKucp9d6zGTD7YPf13CJnsfpboydHJTL+iMB
u4pXYgc39AQe4XoZNDjq5BWKZJT9ZX9Oux6l/v1OftvJNehean5l8b0g7saI5q1u
XuwdorPT4ESfcA3ntlOqhCB/MuLOX+N6KIL1rfSSVidIBvzxJFHOzZ6HB7tnvoVl
1L9ZyasPa1TZlWA4L7LpQ9zyXBUa7P9qGQ8mqU6VfKPzIkwOrzk3ixYhiVexUCo8
mcXgcook0RE4G1OptQEwWJhgLueCa8gEXqrU+1aL3JxEVc8Jt/SoiO4ThDrEyIP4
pucPzgINf1PxKZgqFT2j
=+kB2
-----END PGP SIGNATURE-----

--XQ/JOjNzrAcf1KaA--
