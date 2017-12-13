Received: from eggs.gnu.org ([2001:4830:134:3::10]:38854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePAhu-0004aI-5v
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 12:20:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePAhq-0001kC-OE
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 12:20:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ePAhq-0001j1-DQ
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 12:20:30 -0500
Date: Wed, 13 Dec 2017 17:20:17 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171213172017.GD8317@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-14-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AbQceqfdZEv+FvjW"
Content-Disposition: inline
In-Reply-To: <20171205055200.16305-14-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v5 13/26] qmp: introduce some capability
 helpers
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


--AbQceqfdZEv+FvjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 01:51:47PM +0800, Peter Xu wrote:
> Introduce qmp_cap_enabled() and qmp_oob_enabled() helpers.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--AbQceqfdZEv+FvjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMWFRAAoJEJykq7OBq3PIXE8IAJf7ClO28Db+AD3b2g3rmsDZ
RGsM5uNDd8j2NwsfEVxlcCXme3WVdPTaXQd0rJ80H3ZHzNGUmF5BeceicXnrXgE0
E9OoDMpTNg+ejXfeMyEra6NIH9PIedr46K0sn8T0r3SCbOoUSSpGLySYlV5wf3Xm
zshDWem1TIPbbIDcffDm1pCnlR9i6QAnpGBXJIGQKRItF0aIUO18eegBb6yUnCJP
bBX+MsWG523zpiB6tm3qEWJSu/78iXoX2TBN0SpAN4+LSq5i7/KuGvVBwUyqhe0C
SIP0EeuQrmLRitmx1cHunYWRjsmt5Uz4pbWHo5GMnsO5LOseOlmo2fr8h5MKPrw=
=KGqi
-----END PGP SIGNATURE-----

--AbQceqfdZEv+FvjW--
