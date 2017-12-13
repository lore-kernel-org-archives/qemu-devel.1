Received: from eggs.gnu.org ([2001:4830:134:3::10]:36865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eP8xh-000096-JU
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 10:28:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eP8xc-0001yf-1C
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 10:28:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eP8xb-0001yN-Pv
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 10:28:39 -0500
Date: Wed, 13 Dec 2017 15:28:31 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171213152831.GE7173@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-5-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Epv4kl9IRBfg3rk"
Content-Disposition: inline
In-Reply-To: <20171205055200.16305-5-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v5 04/26] monitor: move skip_flush into
 monitor_data_init
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


--4Epv4kl9IRBfg3rk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 01:51:38PM +0800, Peter Xu wrote:
> It's part of the data init.  Collect it.
>=20
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--4Epv4kl9IRBfg3rk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMUcfAAoJEJykq7OBq3PIxzkH/2Aa7beVkuJkmOCfd983DWF1
6AKAK/DwIQWFqpUMhQp2mN1zGEE6DvORCjGFbsUAKbysv3AUrMAw/mBBZhx6NHFi
DjJY5xU1MeMVEYwMbTYSAHx0TBF21LywC/3DoYJv/MH7r29RZtPiDvTiDe5MVM56
G06vSWXGtrfHm8GDoBSU3zeRWR58GRsDWqm1/uCN17MBOqq/eAT0lniVCyzF3V5+
6BYyGIdpyQhIJwSvkbvkI46zKmiQU23hdNWiKnsLj09LiZg2lnHjhlNj6W9fkx8I
MkNO5U7O/N1mhUAspod8vaTBo4C2etMQA2KwS/bN73+8ZxrBgrE/bx4uCbS4PBc=
=OqOL
-----END PGP SIGNATURE-----

--4Epv4kl9IRBfg3rk--
