Received: from eggs.gnu.org ([2001:4830:134:3::10]:43575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fO0k7-0007vg-FN
	for qemu-devel@nongnu.org; Wed, 30 May 2018 09:02:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fO0k2-0001El-1Q
	for qemu-devel@nongnu.org; Wed, 30 May 2018 09:02:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44310 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fO0k1-0001EJ-T4
	for qemu-devel@nongnu.org; Wed, 30 May 2018 09:02:13 -0400
Date: Wed, 30 May 2018 13:54:39 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180530125439.GK14623@stefanha-x1.localdomain>
References: <20180529193730.9204-1-crosa@redhat.com>
	<20180529193730.9204-3-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mPOSj6iWmtyhwOMz"
Content-Disposition: inline
In-Reply-To: <20180529193730.9204-3-crosa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/5] scripts/qemu.py: allow adding to
 the list of extra arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Fam Zheng <famz@redhat.com>, Amador Pahim <amador@pahim.org>


--mPOSj6iWmtyhwOMz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 29, 2018 at 03:37:27PM -0400, Cleber Rosa wrote:
> Tests will often need to add extra arguments to QEMU command
> line arguments.
>=20
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  scripts/qemu.py | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--mPOSj6iWmtyhwOMz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbDp8PAAoJEJykq7OBq3PIpBAIAKvtxjOoqG0gpS59jyvr2fIC
x2qaa8O9xQkI7HSrZWIWGCHOb8/ikMjRC1NojA2cpAP2j5RRO+NfQmMhogwscwet
HQJjnDcUFN/eHisKyr5A5xE4OENN/uY7VBUVhCDhDWQ3UZ1aWePMkWDoKBZqqzXb
uvLHbhV1ftT989IJ1zty6sIoiXTxtz7cSQKWMCz3QPokM5GeRqQTV2F19YLxcdTt
coWEmGaUTt2yVzw2+eyjmRkYu3/jOBFqh7k29JW7WsfBhbqyzbA33G6bFa3/pA0x
9xucH4mR9bAuBr26Y1lqiQiwXVgi99piLp5D5hJisCqdqws7UQQa0HDpJyS72RI=
=3v1I
-----END PGP SIGNATURE-----

--mPOSj6iWmtyhwOMz--
