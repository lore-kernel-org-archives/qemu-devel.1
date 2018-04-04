Received: from eggs.gnu.org ([2001:4830:134:3::10]:39093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3f0g-0002zI-Np
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:47:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3f0d-0001nG-NX
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:47:18 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:33353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1f3f0d-0001mv-Ed
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:47:15 -0400
Received: by mail-wm0-x232.google.com with SMTP id o23so20326616wmf.0
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 02:47:15 -0700 (PDT)
Date: Wed, 4 Apr 2018 10:47:12 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180404094712.GJ4467@stefanha-x1.localdomain>
References: <69678ef4.64d2.1626aefe0be.Coremail.hellokittyme@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6THr7QwYWIbrk6Kt"
Content-Disposition: inline
In-Reply-To: <69678ef4.64d2.1626aefe0be.Coremail.hellokittyme@163.com>
Subject: Re: [Qemu-devel] cpu_memory_rw_debug function is too slow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: iscccc <hellokittyme@163.com>
Cc: qemu-devel@nongnu.org


--6THr7QwYWIbrk6Kt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 28, 2018 at 12:48:48PM +0800, iscccc wrote:
> Hello, I found that use cpu_memory_rw_debug in tcg mode when qemu access guest virtual address is too slow, can I choose to use some other more fast function ?

Please explain what you are trying to do.  It's hard for anyone to give
advice without context.

Stefan

--6THr7QwYWIbrk6Kt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaxJ8gAAoJEJykq7OBq3PIbogIAJ7jkgFDPr4UPCR72+RT/3F2
efSeIiukt5XU1j1Om3zsKZLlLQ1txVrAWEgRFIOV3qoXrR1c/C+iOpbZxYhUcMfT
9xAieR+u49G4//Ns03ft1L1dZen7gpRJ5c8AXhvWYZTsllRWiAUHsuoFf3KKw5Vi
HVPYgn1YjhGJejfpEHVy5lDUB6jXdXNAVEozd0LixZObrS72S3PTJwRUSGoLWQPa
2p9+x6p+WhInYLH5SafmORwtBFUT/bBhn0MxnrdrJ7QLmEK6z48gZGy3iT4hRXaR
3bwBvW9faheEOHlhiAuU3U5n4rAtDTJkIWJtioLyok4vo3GL5aTSBxhQOA/7dRw=
=zSAU
-----END PGP SIGNATURE-----

--6THr7QwYWIbrk6Kt--
