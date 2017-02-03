Received: from eggs.gnu.org ([2001:4830:134:3::10]:58692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cZfj2-0003nq-Lk
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:24:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cZfiz-0005hP-Gk
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:24:36 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33921)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cZfiz-0005gm-A3
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:24:33 -0500
Received: by mail-wm0-x241.google.com with SMTP id c85so5027043wmi.1
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 07:24:33 -0800 (PST)
Date: Fri, 3 Feb 2017 15:24:30 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170203152430.GI642@stefanha-x1.localdomain>
References: <20170203003212.21992-1-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ijf6z65S790CMqo8"
Content-Disposition: inline
In-Reply-To: <20170203003212.21992-1-haozhong.zhang@intel.com>
Subject: Re: [Qemu-devel] [RESEND PATCH v2] docs: add document to explain
 the usage of vNVDIMM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, Xiao Guangrong <guangrong.xiao@linux.intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--ijf6z65S790CMqo8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 03, 2017 at 08:32:12AM +0800, Haozhong Zhang wrote:
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> Reviewed-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> Changes since v1:
> * explicitly state the block window mode is not supported (Stefan Hajnoczi)
> * typo fix: label_size ==> label-size (David Alan Gilbert)
> ---
>  docs/nvdimm.txt | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 124 insertions(+)
>  create mode 100644 docs/nvdimm.txt

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ijf6z65S790CMqo8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYlKCuAAoJEJykq7OBq3PICGQH/iA3Lhvef0IeVBoR+/Pw8r/t
3LMl1bpRaY4qU4WhUtgsyVOhduwyG3+789MVb0jrGLHQoutPL/r32HRx/Ix0z0Q0
wQbKbMZn51990hueuVt3yYf8WskKHP1rTipUTkPbXoWZ49MOmVkMMmo6TERUFhsV
GY8GKA3Z3xoF6viIkFdJyQKYIfk8BUZxDssOkzcw69O4pwxYsiEfQyq9GoU6CYuQ
uukGTjPX6khVIhFJBq7oGhZQk5J6MYjSGpA0aI4PvzSASmK9v0lhgIHfzOXO1Ue5
8IVybwf/AVuHIDnsfNFnfJNVa6uwbpH19Ms38Xus8wF+eE6FmiEo949WhHS/5ZQ=
=pOqR
-----END PGP SIGNATURE-----

--ijf6z65S790CMqo8--
