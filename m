Received: from eggs.gnu.org ([2001:4830:134:3::10]:43874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cQchC-0005Ci-T8
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:21:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cQch8-0002Ns-Tu
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:21:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cQch8-0002NW-OB
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:21:14 -0500
Date: Mon, 9 Jan 2017 16:12:22 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170109161222.GG30228@stefanha-x1.localdomain>
References: <148278447806.8988.12706825771606357198.stgit@fimbulvetr.bsc.es>
	<148278449970.8988.13860069214737116263.stgit@fimbulvetr.bsc.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="APlYHCtpeOhspHkB"
Content-Disposition: inline
In-Reply-To: <148278449970.8988.13860069214737116263.stgit@fimbulvetr.bsc.es>
Subject: Re: [Qemu-devel] [PATCH v4 4/6] hypertrace: [softmmu] Add QEMU-side
 proxy to "guest_hypertrace" event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Daniel P Berrange <berrange@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>


--APlYHCtpeOhspHkB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 26, 2016 at 09:34:59PM +0100, Llu=EDs Vilanova wrote:
> +#define PAGE_SIZE TARGET_PAGE_SIZE

Unused.  Please remove.

--APlYHCtpeOhspHkB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYc7ZmAAoJEJykq7OBq3PIWCIIAKC5S7slmVHas8wnD29pr8mZ
rIM7cmSqYWKehZIZNyFrWVqdd4V/+rJB0qMGcdZ9eKbmeamsxERD03Dz2k3mOo82
wNBZwU4P3nsN9z3pUb+KKN1PJgbNayfdeeWIgBkIB7pIKAMw3HrZVcqHYjW/Zjql
w7u0ZGJlogewhcz7Do8SCugeYTPnHBHsDXlqw9X9Ebx+ZVjHGTgAlKTCrsH5By0x
KsNDinzONMNR5rca1dyUKF7phHdy2cXLLj4F5nYdMAHry9UiL3xrvzMA6Rq849dy
pJyQ+gz2cbaN8wLpKg8TGoLArVJcVMljmar453p75dXYx6ofST73chbGId9vjcQ=
=+9VL
-----END PGP SIGNATURE-----

--APlYHCtpeOhspHkB--
