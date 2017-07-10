Received: from eggs.gnu.org ([2001:4830:134:3::10]:38299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUb8J-0001NQ-4x
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUb8I-0004RD-4Y
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:01:59 -0400
Date: Mon, 10 Jul 2017 17:01:43 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170710160143.GR14195@stefanha-x1.localdomain>
References: <20170706163828.24082-1-pbonzini@redhat.com>
	<20170706163828.24082-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SWsnvgFfkTS2ATo5"
Content-Disposition: inline
In-Reply-To: <20170706163828.24082-9-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 08/11] block: drain I/O around key
 management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org


--SWsnvgFfkTS2ATo5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2017 at 06:38:25PM +0200, Paolo Bonzini wrote:
> The resulting drained section is a replacement for the AioContext.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  blockdev.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--SWsnvgFfkTS2ATo5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZY6TnAAoJEJykq7OBq3PIOB8H/3flEe51vVj3pV08QxRg+KMn
S7mMuKTFREcH414HGKepuAa9eEGlrX/vUUxfmAedrpffuEriDOvKKTDUxRMvgyMV
YbMauSSqaOnxGzMVo3JxaG18ppnwrT6lMR0SwLs2tT2l9LCNM7Q/vWzle52abHeL
K3U/ysVy4H22uwC201oKJorF+y2/Og2M30ORR/I/49+HCLCSkCDkTeyoaZiImoji
25T4Y5eC74OvDvG/uMaHFEVSXwuAq+029m5r3SuancHZ4TZaVyYFS96RHZZnmB1S
SJgW0KQ4ZUKiNPE7gFwb5GIiNm3kG/wCcrs3bw6fyelgbf8m3yV0C3W771S2Eys=
=YauV
-----END PGP SIGNATURE-----

--SWsnvgFfkTS2ATo5--
