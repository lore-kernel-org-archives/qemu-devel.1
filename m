Received: from eggs.gnu.org ([2001:4830:134:3::10]:44686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWOlK-0003Du-18
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:41:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWOlG-000600-U0
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:41:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cWOlG-0005zq-Nm
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:41:22 -0500
Date: Wed, 25 Jan 2017 14:41:20 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170125144120.GO10664@stefanha-x1.localdomain>
References: <20170124110151.937-1-berrange@redhat.com>
	<20170124110151.937-8-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JfVplkuTfB13Rsg5"
Content-Disposition: inline
In-Reply-To: <20170124110151.937-8-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 7/8] trace: update docs to reflect new
 code generation approach
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, Paolo Bonzini <pbonzini@redhat.com>


--JfVplkuTfB13Rsg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2017 at 11:01:50AM +0000, Daniel P. Berrange wrote:
> Describe use of per-subdir trace events files and how it impacts
> code generation.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  docs/tracing.txt | 55 ++++++++++++++++++++++++++++++++++++++++++++------=
-----
>  1 file changed, 44 insertions(+), 11 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--JfVplkuTfB13Rsg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYiLkQAAoJEJykq7OBq3PI8j4IALNtbmXUnUThiYZTsptUqQmJ
/qO+ZHgeH80itHeX7VEY19L9QaTGNPwdHqt8nu7dLACwRnXzVI6/aYJKgDUcSXBW
UtOdtrJbCG9fHXdZpmOqM/MsHf7Ggsi9fAmW5U+ofwBPL8m2MmPX4zVWB5Y5EfjC
DUvOMy8jkMFnnF0wh+9S8DCH4m1HVrSHaZisp9EtseJRWOq1dfH9VQOO4atBHgAX
Bvcq751Y6DiZVl9NzdY9vZ/4CmYlKPrB/NlcZ9LHAjHRqWbNrDSLss84GOCSMB0C
r3MSuJXFqkM2yNOY7fqFuXdSWYP9NO7agVdF1vS5x4Uox26DZQWWbK+2g1AMQ88=
=wf3y
-----END PGP SIGNATURE-----

--JfVplkuTfB13Rsg5--
