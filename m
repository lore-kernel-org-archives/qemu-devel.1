Received: from eggs.gnu.org ([2001:4830:134:3::10]:37586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fQvJ7-00071X-PZ
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:50:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fQvJ6-00034d-JI
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:50:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58284 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fQvJ6-00031D-Aa
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:50:28 -0400
Date: Thu, 7 Jun 2018 14:50:20 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180607135020.GQ19032@stefanha-x1.localdomain>
References: <1527840629-18648-1-git-send-email-junyan.he@gmx.com>
	<152784163262.348.14845375943329962378@d39dc562802a>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OxDG9cJJSSQMUzGF"
Content-Disposition: inline
In-Reply-To: <152784163262.348.14845375943329962378@d39dc562802a>
Subject: Re: [Qemu-devel] [PATCH V6 0/7] nvdimm: guarantee persistence of
 QEMU writes to persistent memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: junyan.he@gmx.com, famz@redhat.com, haozhong.zhang@intel.com, xiaoguangrong.eric@gmail.com, crosthwaite.peter@gmail.com, mst@redhat.com, dgilbert@redhat.com, ehabkost@redhat.com, quintela@redhat.com, junyan.he@intel.com, pbonzini@redhat.com, imammedo@redhat.com, rth@twiddle.net


--OxDG9cJJSSQMUzGF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 01, 2018 at 01:27:14AM -0700, no-reply@patchew.org wrote:
> /tmp/qemu-test/src/stubs/pmem.c: In function 'pmem_persist':
> /tmp/qemu-test/src/stubs/pmem.c:23:1: error: control reaches end of non-void function [-Werror=return-type]
>  }
>  ^
> cc1: all warnings being treated as errors

Looks like another revision of this series will be necessary.

Stefan

--OxDG9cJJSSQMUzGF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbGTgcAAoJEJykq7OBq3PIIUIH+wWxuv3zA7wxG0IfHU7jsKKV
5YBns0qUnZUcr3V+gKQ56EyZVlwIoXXxcs2k0pREYaNW+YQAVzwTQgg3plyojQ86
/XkE7ClPbt+vvTGKsLi1RZpXzO79F3rMe29BqCdrJRgkpTGuPTRL6mcYFpQbcm8v
xTm17JGnqZiTwQpWj0/DuygZpylVg6Pujx3NV8XlIdfiftrsTVa0OYE/guGovWc2
D1AulzsI10CLnHxAVi1XF64laEUhv6Qi0cRjfgDGjKU53gaXehmi+blyDyrM2cHx
/idjad+iAQ2W1gI9qEum5lB8xm01zqbW9axTMfqecvW3nB07oDTteBxGwzY0Mk4=
=D1zD
-----END PGP SIGNATURE-----

--OxDG9cJJSSQMUzGF--
