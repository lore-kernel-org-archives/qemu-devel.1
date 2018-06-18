Received: from eggs.gnu.org ([2001:4830:134:3::10]:36266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fUwVY-0006i8-91
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 11:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fUwVV-0002Uu-7x
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 11:55:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60002 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fUwVV-0002Un-2i
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 11:55:53 -0400
Date: Mon, 18 Jun 2018 16:55:50 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180618155550.GD9785@stefanha-x1.localdomain>
References: <20180615014249.22730-1-peterx@redhat.com>
	<20180615014249.22730-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="76DTJ5CE0DCVQemd"
Content-Disposition: inline
In-Reply-To: <20180615014249.22730-2-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/6] chardev: comment details for CLOSED
 event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--76DTJ5CE0DCVQemd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 15, 2018 at 09:42:44AM +0800, Peter Xu wrote:
> It was unclear before on what does the CLOSED event mean.  Meanwhile we
> add a TODO to fix up the CLOSED event in the future when the in/out
> ports are different for a chardev.
>=20
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: "Marc-Andr=E9 Lureau" <marcandre.lureau@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/chardev/char.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--76DTJ5CE0DCVQemd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbJ9YGAAoJEJykq7OBq3PITJIIAJJsYCDuuOCtIn2DdeDUmxVt
rYkpO33bA4Nhg9JiXvCoasgIOjCri3lmz1A6jpC7vz+rynhxzO/dT9pSCgHuAQ6O
Ijw+f75emqpkMEBxvpmYZOU7wvur9LRpLjfLwPUZFh05P7IIyg6RJDaKPUS9sJcT
d2ozjjK5V4+NYSXsnI7y8jHTgPtgn0ZNxXP4U14gtfPfZzBeMicQdMoYFi9B8KZg
07oB0BwQGb+3YnwpeOzljDsuKYsTnY4z39VYYcgx7aH6pKMR0xGX5dHol79GOIfD
BA0VzTgtTtcuoy40in1Hz5HFDDY1fwTPw76Z5iQDxKa854tS+ZXVbR9EGwTmMzU=
=A9Ga
-----END PGP SIGNATURE-----

--76DTJ5CE0DCVQemd--
