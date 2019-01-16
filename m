Received: from eggs.gnu.org ([209.51.188.92]:55863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gjm9f-0003Rv-MC
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:26:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gjm9e-0007Sj-BR
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:26:55 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:32941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gjm9e-0007Pj-3h
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:26:54 -0500
Received: by mail-wm1-x330.google.com with SMTP id r24so1184687wmh.0
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 06:26:54 -0800 (PST)
Date: Wed, 16 Jan 2019 14:26:51 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190116142651.GE16898@stefanha-x1.localdomain>
References: <1547615970-23545-1-git-send-email-changpeng.liu@intel.com>
	<1547615970-23545-2-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JBi0ZxuS5uaEhkUZ"
Content-Disposition: inline
In-Reply-To: <1547615970-23545-2-git-send-email-changpeng.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/3] contrib/vhost-user-blk: fix the
 compilation issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changpeng Liu <changpeng.liu@intel.com>
Cc: qemu-devel@nongnu.org, sgazare@redhat.com, stefanha@redhat.com, mst@redhat.com


--JBi0ZxuS5uaEhkUZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 16, 2019 at 01:19:29PM +0800, Changpeng Liu wrote:
> Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> ---
>  contrib/vhost-user-blk/vhost-user-blk.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--JBi0ZxuS5uaEhkUZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcPz8rAAoJEJykq7OBq3PIBxYIALl2u4MZ8EFjUNS2BY7/0DTa
DJrenLVZqU7ai6ZbR6FPK3NYKp4chZxO7TOliJoqnGO/RY9bYYdXDJ9QnMyrnd7I
yUPIiprN5a3cEZOzCGmq7JcjEKO3I7gIETyURld+wHmQLczL5Uv5/O76COXT9iOC
nbF3/SIAlk7geUV63U+jfiE4k2L0rl1kb635TMAdDGTK0x9/kaNMP0OoHBaCoeBg
b/hH5XA6E7QaHowr5WYpb4hYB9KBfBYqqUmexLnQj4d5yC8CM5EyTCNApPPcYZql
ZdGhHfNGkEF+5AZWm6XuwTpwf+WPeNecTIcnwYy6xqNaHSVHSJCQjjUQwSWykW8=
=Rrk9
-----END PGP SIGNATURE-----

--JBi0ZxuS5uaEhkUZ--
