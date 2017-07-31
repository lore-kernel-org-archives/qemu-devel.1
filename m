Received: from eggs.gnu.org ([2001:4830:134:3::10]:33977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dc6xr-0002Gu-Bm
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 05:26:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dc6xm-0003bi-GG
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 05:26:15 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:33791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dc6xm-0003bO-9Q
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 05:26:10 -0400
Received: by mail-wm0-x229.google.com with SMTP id k20so13771151wmg.0
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 02:26:10 -0700 (PDT)
Date: Mon, 31 Jul 2017 10:26:06 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170731092606.GD11830@stefanha-x1.localdomain>
References: <20170729131159.24949-1-vsementsov@virtuozzo.com>
	<20170729131159.24949-4-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DrWhICOqskFTAXiy"
Content-Disposition: inline
In-Reply-To: <20170729131159.24949-4-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] checkpatch: check trace-events code
 style
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, eblake@redhat.com, mreitz@redhat.com, jsnow@redhat.com, den@openvz.org, peter.maydell@linaro.org, berrange@redhat.com


--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 29, 2017 at 04:11:58PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Accordingly to CODING_STYLE, check that in trace-events:
> 1. hex numbers are prefixed with '0x'
> 2. '#' flag of printf is not used
> 3. The exclusion from 1. are period-separated groups of numbers
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  scripts/checkpatch.pl | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZfveuAAoJEJykq7OBq3PI7L0H/isulF9ZvDX9bomgV9KRw6SE
eZn0S5JM41l0L5PqqEvGZYIZl/s+w0N0iN8LvRfXmlGwB8n4DQIX/oASqTJs8WC4
j+bpUdAX+374mZqg7qqvs4kbmbmV0R4dijt/rAcJs40NPJwuZ5vPdBdZTfuu/Zsh
butXKEkAxUmzTdSMTlOmlyk8XhXw6Nnuw8XdbCGxbi250yNcf5tKaODXG4Q/6CUl
L291FnllWKkp7BWaTUeJw1xf8VR/Dkp1pFGd0kKFYBTaf6AGPjpV3W0lokDEytQg
gwZELyEYstxUTEsGHycR4oDbbp0AE8OQ0qAAH/nNv72hM25GnyH1kBPQPVqX3ME=
=x1/Y
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--
