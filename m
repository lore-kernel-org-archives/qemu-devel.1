Received: from eggs.gnu.org ([2001:4830:134:3::10]:37245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cQcGH-00008V-Iu
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 10:53:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cQcGF-0006b7-GW
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 10:53:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cQcGF-0006af-AG
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 10:53:27 -0500
Date: Mon, 9 Jan 2017 13:43:10 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170109134310.GE30228@stefanha-x1.localdomain>
References: <58733617.3050503@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8vCeF2GUdMpe9ZbK"
Content-Disposition: inline
In-Reply-To: <58733617.3050503@huawei.com>
Subject: Re: [Qemu-devel] Question about add AF_ALG backend for virtio-crypto
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng (Mike)" <longpeng2@huawei.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU-DEV <qemu-devel@nongnu.org>, "Wubin (H)" <wu.wubin@huawei.com>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>, Gonglei <arei.gonglei@huawei.com>


--8vCeF2GUdMpe9ZbK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 09, 2017 at 03:04:55PM +0800, Longpeng (Mike) wrote:
> I'm one of Gonglei's virtio-crypto project members, and we plan to add a =
AF_ALG
> backend for virtio-crypto(there's only builtin-backend currently).
>=20
> I found that Catalin, Paolo and Stefan had discussed about this in 2015
> (http://www.spinics.net/lists/kvm/msg115457.html), but it seems that Cata=
lin
> didn't do it, so I'm confuse about wether it is need to add a AF_ALG back=
end.
>=20
> Do you have any suggestion? Thanks :)

I have no objections to an AF_ALG backend in QEMU.

Stefan

--8vCeF2GUdMpe9ZbK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYc5NuAAoJEJykq7OBq3PIPHMH/3EkkFUskTXm9ZZnfhIuK+e7
usxK1Uk2O/QSCZA2G+pzIGyzj5FBQkK1mQp7plqzOZ9XwOPskQEGa/RBIyFZhIJ5
qyZs4Oyg4VbaYjekcQfik7Yy2jdgW/UL7Ka2XNAmTwjxdxp9Oa40D0YB4I5riDzj
1GxAHGyorvEuShGxqz/Ad+liGr7f2M/3tHP2kmO8EzNc+mpYSsI47epU6vnJ7t9d
ioxzptB6u+5K6eV+z7M+zVuAsvZ3py4qU6idN0466dqizvm8Xf+kvhcakx8IbRdD
dskFUsfYi8kLwhnrO1+7LyWf4aOIT7/T+s0KsWuEp/Uu75YTzgSmSmSsp6AMyrY=
=TmG0
-----END PGP SIGNATURE-----

--8vCeF2GUdMpe9ZbK--
