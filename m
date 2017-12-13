Received: from eggs.gnu.org ([2001:4830:134:3::10]:36293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eP8v0-0006uH-KE
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 10:25:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eP8ux-0000hm-H1
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 10:25:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eP8ux-0000gu-A5
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 10:25:55 -0500
Date: Wed, 13 Dec 2017 15:25:29 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171213152529.GC7173@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p2kqVDKq5asng8Dg"
Content-Disposition: inline
In-Reply-To: <20171205055200.16305-3-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v5 02/26] qobject: introduce
 qobject_get_try_str()
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


--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 01:51:36PM +0800, Peter Xu wrote:
> A quick way to fetch string from qobject when it's a QString.
>=20
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/qapi/qmp/qstring.h |  1 +
>  qobject/qstring.c          | 11 +++++++++++
>  2 files changed, 12 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--p2kqVDKq5asng8Dg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMUZpAAoJEJykq7OBq3PI11gH/jGcekdmUNQ2yxvb9SZpTTIF
nyf9QhwngD4QBN3VaBq/TEHXRgCJak/1Wd9IJ9YV8hLYo696tJAWTXEF1d0W3Trh
lQdttG3QE8AorfQlmpK9K8up4FhpotBwQDJlksncicRppaWtktEX4nDeQTuZqFk5
NmLMmvef2YmO9AsmWSdImE+WIIOohW9z/HZG63KNxcP7fpFUXNX0TJAKfZDn/aVb
7utAIEiv1HcCopvlnqYHpElD9Sm24RaRfbeNYJcI9qvlLqULlgFS+7VFoKteC5uD
AvtW25HFRFVcBDoxdsDHyBHeF6DWJMgpuNxCIZvWRQyGKlrX4/BUPnhuimzmNoY=
=AeBM
-----END PGP SIGNATURE-----

--p2kqVDKq5asng8Dg--
