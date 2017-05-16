Received: from eggs.gnu.org ([2001:4830:134:3::10]:48356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAdXe-00067n-5s
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:33:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAdXa-0003xE-8A
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:33:38 -0400
Received: from mail-lf0-x229.google.com ([2a00:1450:4010:c07::229]:33464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dAdXa-0003wU-1P
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:33:34 -0400
Received: by mail-lf0-x229.google.com with SMTP id m18so12862365lfj.0
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 07:33:33 -0700 (PDT)
Date: Tue, 16 May 2017 15:33:30 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170516143330.GB18270@stefanha-x1.localdomain>
References: <20170516052439.16214-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
In-Reply-To: <20170516052439.16214-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] fix mingw build failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 16, 2017 at 07:24:39AM +0200, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  crypto/random-platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZGw26AAoJEJykq7OBq3PIcD4H/R9CjnPkzNA3QZk1LLRTsGtA
9MolSFuzfJ5reLit/9r0BDylTPOPhIElQgcq1KUc/4obQFuaFgEbzJrvUH99AUry
eK1un/OErXPpJ1cyFAJlHr9vZF4/fbK2e3+LbLQbE6v/HxXEpaIXvFJXOMrglRZs
BzKp1SP8k/Ff1JhDeA9E1bn6kohkHq1rh1+v42yCwsFmsFdqYKBHTyuFNR8qogN3
5M8laT92oJUcZYhErxI3xek1LdKq/v9Ao+cTB4O1tW2Is1KiVHMCsw3j7TwgCxks
/yUEpzF28FoxdzKYMGPTjuGLEchIjcn/FfPpxU6ymJbozSU3kLH7OXFJe8gNhpY=
=wdP0
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
