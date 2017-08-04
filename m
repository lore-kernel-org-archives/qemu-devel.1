Received: from eggs.gnu.org ([2001:4830:134:3::10]:50884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ddcVk-0000V4-B2
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ddc5i-0004d1-KH
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 08:53:40 -0400
Date: Fri, 4 Aug 2017 13:49:50 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170804124950.GC14565@stefanha-x1.localdomain>
References: <20170804105059.11941-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bAmEntskrkuBymla"
Content-Disposition: inline
In-Reply-To: <20170804105059.11941-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: document semanatics of
 bdrv_co_preadv|pwritev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>


--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 04, 2017 at 11:50:59AM +0100, Daniel P. Berrange wrote:
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  include/block/block_int.h | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--bAmEntskrkuBymla
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZhG1uAAoJEJykq7OBq3PIQR0H/22aXH86ELARhUckycNDyano
m5mWtGgtrX/3aG8dEWR9icRVfDP24O2VSsp7IlwKNm4lMvskvii2TOVqJtoBdcwU
5dz2cJDYURBi3HbQS9cCFl1X1EvCU0TO4F4uSauWxNZuGL9JHeDly72dnhrekqQ9
NivwWFpF/RP+ahfqzgtaXHOaCrCFayvW91KOJLe5/svch5Q/c1ki6KOgJE2U8N/y
SrlgKfLZiRsQxNkbs+36dRPstqJAHeGbAyoeeoHxbo1RteGX87dYV1Ya8mSFFkLK
bdhbS9Fu8vKXSLDGuq94WTEX+TUJqiCC0LscpEsdsSE5bCyE3FCEgnZBPHKJsZ4=
=F/3n
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--
