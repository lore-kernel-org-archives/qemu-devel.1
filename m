Received: from eggs.gnu.org ([2001:4830:134:3::10]:57489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etxjS-0003y7-1P
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:45:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etxjO-0007ph-Tg
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:45:26 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:34096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1etxjO-0007pM-Mk
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:45:22 -0500
Received: by mail-wr0-x242.google.com with SMTP id o8so6155731wra.1
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 07:45:22 -0800 (PST)
Date: Thu, 8 Mar 2018 15:45:19 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180308154519.GC2769@stefanha-x1.localdomain>
References: <20180306024328.19195-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ZLFUWh1odzi/v6L"
Content-Disposition: inline
In-Reply-To: <20180306024328.19195-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] README: Fix typo 'git-publish'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 06, 2018 at 10:43:28AM +0800, Fam Zheng wrote:
> Reported-by: Alberto Garcia <berto@igalia.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  README | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaoVqPAAoJEJykq7OBq3PIIpMIAJecIfXyj9FZqcoKgcfY2NTy
73dla4t3N+VjkGpiTXGmz1T/QgYie3uwwg5UPfMeotrnY4NPMgRCt+W2N/3xy0kF
7mRgQS9Nv9g/PjKSZBQmO9eGqDtgwZcOYWcAG5DFS90LRnGEL1Mxqtl0kRRDCzI7
kPm9BLJfPKqmpkLxJiSThfScBXOFuNAtETDQ/JvotZRZfJgZKLNbIci/2RZcjna4
vl/FGIwn/cS+SZlLuk/UbXLUz4BDRN1A6GMXJ8qIUld20WPQF8WefFsKrlDCnZUn
9N7BjafHvaMsjPequ9FQN9GkBK8IHWX5i1jZd6a/U04MWL3wAo74lbGvwc9wQY4=
=HyBh
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--
