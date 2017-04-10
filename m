Received: from eggs.gnu.org ([2001:4830:134:3::10]:34669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cxVc6-0007k6-R4
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:27:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cxVc3-0006my-O2
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:27:58 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:37628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cxVc3-0006l3-I2
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:27:55 -0400
Received: by mail-wm0-x229.google.com with SMTP id u2so32345548wmu.0
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 02:27:55 -0700 (PDT)
Date: Mon, 10 Apr 2017 10:27:52 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170410092752.GF2567@stefanha-x1.localdomain>
References: <20170323173928.14439-1-pbonzini@redhat.com>
	<20170323173928.14439-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+jhVVhN62yS6hEJ8"
Content-Disposition: inline
In-Reply-To: <20170323173928.14439-2-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/10] blockjob: remove unnecessary check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, jcody@redhat.com, jsnow@redhat.com


--+jhVVhN62yS6hEJ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2017 at 06:39:19PM +0100, Paolo Bonzini wrote:
> !job is always checked prior to the call, drop it from here.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  blockjob.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--+jhVVhN62yS6hEJ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY61AYAAoJEJykq7OBq3PIrKMH/2prejb7TfDNE3HG2gT2GbLq
FXHJqrkSKCnb5UBoqeHfZnIvGE4KNsxmikU6wH6YZsmHyWA4p06flXie3OTD2U5q
00grXTLHIou8HUMrsjk+7Cf+tA0YpAPjgT3QzWhD9gIHLOVSOCw8FpkfwhqLkAng
7l3OIcyxb8SwHmthlMsP2LaLXwBVoRYDzKdrkrW0h0zW/Jc2V2vYQ1Xk3/lqaQeY
HxsnPcHiaY3h8oV35sOEIxRrT/UW0NNWxJ8oIZRK4gPNMGeHZZE/qme86yhhnPGB
hinM1BFdhg0pvWuNbJXcUr4pdOxhERvKXtdYwECJ/OakAmer0jVLc4m95FDrbrc=
=tuJ0
-----END PGP SIGNATURE-----

--+jhVVhN62yS6hEJ8--
