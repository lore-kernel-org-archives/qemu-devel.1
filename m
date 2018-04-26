Received: from eggs.gnu.org ([2001:4830:134:3::10]:45166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fBiLR-0004RV-Sn
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fBiLO-00033G-7p
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:58:01 -0400
Date: Thu, 26 Apr 2018 15:57:54 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180426145754.GH30991@stefanha-x1.localdomain>
References: <20180418030424.28980-1-famz@redhat.com>
	<20180418030424.28980-3-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPDwMsyfds7q4mrK"
Content-Disposition: inline
In-Reply-To: <20180418030424.28980-3-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH v2 2/7] raw: Implement
 copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>


--ZPDwMsyfds7q4mrK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18, 2018 at 11:04:19AM +0800, Fam Zheng wrote:
> Just pass down to ->file.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/raw-format.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ZPDwMsyfds7q4mrK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa4ejyAAoJEJykq7OBq3PIbXUH+wUPmqdHS/5j7ImpjImNt1c7
39sShcc+s8sPqs1X2TJ8oxSr1qO7jr5/LFnX6nNNFO0qUh0AZigTXEPREBYK9JJ0
2eYFD/aoaIztzXluNi6VXAuE3awwLsfZCYfVMEA+3Ck6tushnEbLCMQVhxPnO3h5
m0+t7uzuPGW1vky6bo6sHqu5QzugUSeZFfMouNMWbCapzrPmG/tiCGS4SCWjp3G1
0OMyx4lI8yxlwAJzKRXL7K9flS9BdOIL+gf5QYN425HUf9tA+UOYRZSd/oANfZX2
moCZNoQZ4bMTUKIYtd92MNZpOKVCvTH7/PscC6D7J4zrXEE7l3LxVaJAh7tnLrg=
=QLe+
-----END PGP SIGNATURE-----

--ZPDwMsyfds7q4mrK--
