Received: from eggs.gnu.org ([2001:4830:134:3::10]:57546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dNaxg-0001Jl-Fh
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 04:26:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dNaxf-0000cI-Pe
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 04:26:04 -0400
Date: Wed, 21 Jun 2017 09:25:53 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170621082553.GB16183@stefanha-x1.localdomain>
References: <20170619150002.3033-1-stefanha@redhat.com>
	<149792017229.30666.17701352767204823343@4a9a010726c0>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
In-Reply-To: <149792017229.30666.17701352767204823343@4a9a010726c0>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: don't shadow opts variable in
 img_dd()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, kwolf@redhat.com, fullmanet@gmail.com, qemu-block@nongnu.org


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 19, 2017 at 05:56:13PM -0700, no-reply@patchew.org wrote:
> collect2: fatal error: ld terminated with signal 9 [Killed]
> compilation terminated.
> Makefile:201: recipe for target 'qemu-system-x86_64w.exe' failed

Spurious CI error - ld(1) out of memory?  Not related to this patch.

Stefan

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZSi2RAAoJEJykq7OBq3PIDNEH/jcaFksX/rVTKwTBHb1Z0ENk
BWMPyYnHy59sRrrXWNJHi4r/lnxJSmr21J266sNI6JkyiVTxJW16wI2CdyULuWSe
rREqj3dh2cu2qaB3BX2otQAwcCwVF05ZenCJd3wHaF3P6PzhaI+2LYoQR+D2QNOX
+6O0w5AgOyISewPOQmOVSdjTJWP3cUviLZ76FtMooNvidBKioExgCQar/i2LN3db
DHmMoxO5oBQ6R6CgzzwnaLXYlkrxTi480znv1brplv4JupJ6t15m5luMmZH1Fi57
B8D+nrLp6AZShzMUspFMW8X2US/4GkD9upS7EFwiWMDS0h+55W3VGwIgFgoyqzY=
=oPT3
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
