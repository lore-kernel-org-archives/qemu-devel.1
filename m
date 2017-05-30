Received: from eggs.gnu.org ([2001:4830:134:3::10]:37499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFdJZ-00034R-VB
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFdJW-0002LH-0h
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:19:45 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:38089)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dFdJV-0002Kq-Q6
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:19:41 -0400
Received: by mail-wm0-x229.google.com with SMTP id e127so91185179wmg.1
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 02:19:41 -0700 (PDT)
Date: Tue, 30 May 2017 10:19:39 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170530091939.GF11362@stefanha-x1.localdomain>
References: <20170526075246.20265-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K/NRh952CO+2tg14"
Content-Disposition: inline
In-Reply-To: <20170526075246.20265-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/22] Docker and block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>


--K/NRh952CO+2tg14
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 03:52:24PM +0800, Fam Zheng wrote:
> The following changes since commit 9964e96dc9999cf7f7c936ee854a795415d19b=
60:
>=20
>   Merge remote-tracking branch 'jasowang/tags/net-pull-request' into stag=
ing (2017-05-23 15:01:31 +0100)
>=20
> are available in the git repository at:
>=20
>   git://github.com/famz/qemu.git tags/docker-and-block-pull-request
>=20
> for you to fetch changes up to 77269bba94ef97de99ae61fdc98629a8704ae2ed:
>=20
>   block: make accounting thread-safe (2017-05-26 09:25:30 +0800)
>=20
> ----------------------------------------------------------------
>=20
> For Paolo's block layer thread safety part I and my docker testing
> enhancements.

Please fix the checkpatch issues.

--K/NRh952CO+2tg14
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLTkrAAoJEJykq7OBq3PIHzsIAKjxNH0ut6zrhFQXgQaP9cWQ
7kUHRjyajPR00B/KqB0vxFBHqmHkG9Vxz/L89B5Xw/uodkFSTEqP5cjKuK9KWBZp
fAv6/tIUcdOFRdApGMz16KXQSNnx04upDPOfnZmPX86LDD0yG29XpNGBPhlmtA1j
7KwnTvUPtOCLaaWMe82JW9uQRveLkuE5jKK15aUJnAwTc04R9L6MubHd+bu9Au/J
4dpIqe5tsCeTVgsuUpct/0SMBFHK5jXgY0zLC/nsRWoXldeQ1Po20NVDTkVF4+5j
WxWSERnMx6C8ZayhP4PTMpWzHu7yHZfzgLpyC+8ubJ/CLBnpjfA8jTvIQkN1o3g=
=E+H2
-----END PGP SIGNATURE-----

--K/NRh952CO+2tg14--
