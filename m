Received: from eggs.gnu.org ([2001:4830:134:3::10]:41558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1df1Z8-0004LK-Pv
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:16:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1df1Z5-0000ia-Gb
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:16:46 -0400
Date: Tue, 8 Aug 2017 11:16:40 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170808101640.GJ16801@stefanha-x1.localdomain>
References: <20170804140826.1351-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCKy2vjPBX+S/5dE"
Content-Disposition: inline
In-Reply-To: <20170804140826.1351-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3] block: document semanatics
 of bdrv_co_preadv|pwritev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--FCKy2vjPBX+S/5dE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 04, 2017 at 03:08:26PM +0100, Daniel P. Berrange wrote:
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>=20
>  - Clarify that @bytes matches @qiov total size (Kevin)
>=20
>  include/block/block_int.h | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--FCKy2vjPBX+S/5dE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZiY+IAAoJEJykq7OBq3PIINEIAJwXU3TnXCBDgMfUft0xK/4U
ge7ZIRC19oXN6ddQvYfFYfiDfStYi8nJMYrnjWuafy7f0Q8/oRHaH7A4xcY4iw8g
gslJdMBKTXKcaCPo8XnCpdNTjfQU4iyHyHr0oqf1rY5+JBgk8q8DRk2LVj4touTs
ZzKnfXLP8Tru2X2ASikdvZHiceLfN1wiwbDUfXzCZXwyNA93Zq6p7qW0JIg5wSh9
3PjlZbhhi6dlHza0pZFkdc3qmUmZa7+pp5WhrKk+z9MM+sF86AXgY+wkNEvQiI9y
OSkPK29gR8XiFbDBrn9bqvSgj9eVR0P6Kgzb0gwZD5aC2Pwu99LhF3+j6ki5ae0=
=iFRq
-----END PGP SIGNATURE-----

--FCKy2vjPBX+S/5dE--
