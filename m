Received: from eggs.gnu.org ([2001:4830:134:3::10]:43517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1egC4V-000383-Qp
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:14:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1egC4T-0002a9-4j
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:14:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:5009)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1egC4S-0002Zd-UZ
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:14:13 -0500
Date: Mon, 29 Jan 2018 16:10:54 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180129161054.GA1191@stefanha-x1.localdomain>
References: <20180129033133.31288-1-famz@redhat.com>
	<20180129110426.GA20446@stefanha-x1.localdomain>
	<e3a60e11-3ce4-effe-b87f-b0112e03eaec@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <e3a60e11-3ce4-effe-b87f-b0112e03eaec@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] docs: Add docs/devel/testing.rst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>, kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org, f4bug@amsat.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2018 at 08:38:29AM -0600, Eric Blake wrote:
> On 01/29/2018 05:04 AM, Stefan Hajnoczi wrote:
> > On Mon, Jan 29, 2018 at 11:31:33AM +0800, Fam Zheng wrote:
> >=20
> > Thanks for writing this!
> >=20
> > I have only reviewed some parts in detail.
> >=20
>=20
> >> +
> >> +On top of libqtest, a higher level library, ``libqos``, was created to
> >> +encapsulate common tasks of device drivers, such as memory management=
 and
> >> +communicating with system buses or devices. Many virtual device tests=
 use
> >=20
> > s/buses/busses/
>=20
> That's one of those stupid English words where both spellings are valid,
> and which one you get is a matter of preference (I can't even call it a
> US-vs.-UK issue).

Thanks, I didn't know there were two spellings for this one.

Stefan

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJab0eOAAoJEJykq7OBq3PIG4sH/RUz6bx84TTh4eXF5C3H35A4
QcEH6V37UMwHU32Xh520mVLBkp0Z10+nEaoUVA09OSCa0kyc+4gwtA6vLM3w8kUx
5Xqx78kbVnN8RqfgZslH0hwa0iFxcBdD/XTKBYCxW+Z+9tIIY3T6XqXO2SCmgXjU
9J7AQC/CUs+mlhaR3KXS4c55GG/Kc3WDMpXVbN1AlnxQqhrtkLNuGItUg6eqQEHV
EGUJ5duuezEE235KkXZKl4fu5ODyRvCBlY6oybwXKwPvTp3smpZynYCuPd7r1HdI
RmQSDtlxoX8t8d1oJbBmno07yVG41j81BdVQfRQqYr4N0QwuOagMjF5HNinDcG8=
=f140
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
