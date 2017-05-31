Received: from eggs.gnu.org ([2001:4830:134:3::10]:54384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2kk-00023M-Ic
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2kj-0007qk-QE
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:29:30 -0400
Date: Wed, 31 May 2017 13:29:20 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531122920.GI16733@stefanha-x1.localdomain>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-9-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dMdWWqg3F2Dv/qfw"
Content-Disposition: inline
In-Reply-To: <1495830130-30611-9-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 08/29] qed: Remove callback
 from qed_copy_from_backing_file()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com


--dMdWWqg3F2Dv/qfw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 26, 2017 at 10:21:49PM +0200, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qed.c | 57 +++++++++++++++++++++++----------------------------------
>  1 file changed, 23 insertions(+), 34 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--dMdWWqg3F2Dv/qfw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLrcgAAoJEJykq7OBq3PIO2kH/jq2QFZhGRwGVuuiJj8oCoNa
U2EAgTsCCfzYC4gdMPefyxrO1tHGsB9AfCPY8HiJ9nR8hhyLFaIqqNc4kB4mg/OY
HxcxdKeQ2oDHZWmufsfnUwOGyfWgtag3ko7kSr44cIwkORlg6+WYxxQDVPGy3eMb
kju+k3HzglEbGZSg2vFtlw7hU8d9Gv76u8NZp7jBRLfFfozioGCC474E043p/RKR
kQ+cunAYvGPbmD84kIgkO/3Mw/SnJRDyI3Ejt37CZuHrAbM0AYhQIt0rvUO1WrxK
hV3xnJrBgFlRv7Ty7TReQoB0Pq4kbVL9ftu1WQQrmp4OKrRe8+RyaTFmz+KucAE=
=mHMT
-----END PGP SIGNATURE-----

--dMdWWqg3F2Dv/qfw--
