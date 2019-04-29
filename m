Received: from eggs.gnu.org ([209.51.188.92]:49175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hL8sJ-0001Z4-2n
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:11:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hL8sI-0004VQ-6V
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:11:27 -0400
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143]:37567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hL8sI-0004Un-1d
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:11:26 -0400
Received: by mail-it1-x143.google.com with SMTP id r85so8493596itc.2
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 09:11:25 -0700 (PDT)
Date: Mon, 29 Apr 2019 12:11:20 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190429161120.GB13640@stefanha-x1.localdomain>
References: <20190426102115.30002-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
In-Reply-To: <20190426102115.30002-1-yury-kotov@yandex-team.ru>
Subject: Re: [Qemu-devel] [PATCH] trace: fix runstate tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 26, 2019 at 01:21:15PM +0300, Yury Kotov wrote:
> Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
> ---
>  vl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcxyIoAAoJEJykq7OBq3PIg3YIAMLlT+gFEqniDXEKkxbgx/TW
6xHsK4UAjWJoArZNOU5O2OTeQnePER5H7OaxamBANxEcfUpNruQ/kYpB+42ckv8i
f4zCIOkDawvR7fAAEERtHoyzjTvFrLD89MLFfPulPXJXTSe7Td/d2idwrnVWWXZZ
qojQmNtftU3txc0+m5jZjHeLwnUeXSsEr9qAFziEHvd9Sr0x8/EOmM4sM1NUzSMu
BucSVueEi91kkiHPGk0YXWr1Z1F3VCDhFUCemr+4jT2DpZ8coO4+IhlOMWBYgKfZ
vwWI3Yb6OyZVaKukmAxW/avxa9pczL7V+enV2Lo/Gq6LWjXVrk53+ZSjW1YEBng=
=V70O
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--
