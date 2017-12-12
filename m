Received: from eggs.gnu.org ([2001:4830:134:3::10]:36742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eOgYo-0007s5-2K
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 04:09:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eOgYn-0007Zj-65
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 04:09:10 -0500
Date: Tue, 12 Dec 2017 09:08:58 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171212090858.GC6089@stefanha-x1.localdomain>
References: <20171212005113.909-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f0KYrhQ4vYSV2aJu"
Content-Disposition: inline
In-Reply-To: <20171212005113.909-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4] qemu-img: Document --force-share / -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kchamart@redhat.com, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>


--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2017 at 08:51:13AM +0800, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
>=20
> ---
>=20
> v4: "images". [Kevin]
>=20
> v3: Document that the option is not allowed for read-write. [Stefan]
>=20
> v2: - "code{qemu-img}". [Kashyap, Eric]
>     - "etc.." -> "etc.".
> ---
>  qemu-img.texi | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--f0KYrhQ4vYSV2aJu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaL5yqAAoJEJykq7OBq3PIeT8H/0LdbIodPI1w9qQbdmdXBy27
kY8eHSftc4JrKh6IUMwpiHqkxZifK1fOz3R4YHCQ4L3zJLqrVUa4pt8nF0dVSGGG
4zDczgTqLGvPGDf3JiOBdkUU0FoR/n5MN1wzqDmcprZZMlSUpxESCifxpHKtkRwg
TyDJ0iBuiXSOKyH+1+49W05OcG8lMapnHhTLQTGGxuLSx6xDWyO2NW4WIg+NDZjY
YYW2P+8RZQAlJCaUW2uPlofitEiq4/wStJo+wJ6YOOYnVsIdW0jUYzQvvcxBghIC
kWRfou/ISt7qMVFcuEA+619W0Cw0IeBDUbnflXfwcO22z8ald0w/eNFP/ORXr/g=
=UrZG
-----END PGP SIGNATURE-----

--f0KYrhQ4vYSV2aJu--
