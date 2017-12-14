Received: from eggs.gnu.org ([2001:4830:134:3::10]:41641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePTpl-0006Is-Mk
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:45:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePTpg-0006EZ-L3
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:45:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ePTpg-0006Cs-EV
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:45:52 -0500
Date: Thu, 14 Dec 2017 13:45:42 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171214134542.GL14433@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-24-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FxavXfDenm+F7xE/"
Content-Disposition: inline
In-Reply-To: <20171205055200.16305-24-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v5 23/26] qmp: add command "x-oob-test"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--FxavXfDenm+F7xE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 01:51:57PM +0800, Peter Xu wrote:
> This command is only used to test OOB functionality.  It should not be
> used for any other purposes.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  qapi-schema.json | 18 ++++++++++++++++++
>  qmp.c            | 16 ++++++++++++++++
>  2 files changed, 34 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--FxavXfDenm+F7xE/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMoCGAAoJEJykq7OBq3PIP2IH/j7hb/ZT9SBxylQ7RHEzys7R
hTwLmTQlWIwcjV8OL/4IRjY88leaAgP4e2gU25ENo/TPQa5vW+d/X5YaaVZCVbGb
Rdr6b4GGlqPMkuHHhQYDlwz71F7pJXcNOAk8H/D+vWqWFloLKhs3cbpNe2SZGCvI
sTB0vvnuJb4/0g5bNhAbZkWqdUQRRfW0rIAOuCAoNSAPpxbjjDMVqvwXZO6grtkX
piaArl/w9Tx/4ZI/O22Vx21NvrOW6/aaGY1xt1oRn1LVojI129B2Jym+FNXbgVMR
mFoXF6k4pODGbCOXeoxQdzqSIoYEUEsC37HlQa18JBtpPa/xZWY5bi9Qu3nisc8=
=GQyr
-----END PGP SIGNATURE-----

--FxavXfDenm+F7xE/--
