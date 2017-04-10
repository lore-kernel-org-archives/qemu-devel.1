Received: from eggs.gnu.org ([2001:4830:134:3::10]:37022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cxVki-0003Ss-7e
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:36:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cxVkf-0002VW-59
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:36:52 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cxVke-0002VI-Va
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:36:49 -0400
Received: by mail-wr0-x244.google.com with SMTP id l28so3538711wre.0
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 02:36:48 -0700 (PDT)
Date: Mon, 10 Apr 2017 10:36:46 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170410093646.GK2567@stefanha-x1.localdomain>
References: <20170323173928.14439-1-pbonzini@redhat.com>
	<20170323173928.14439-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1y1tiN5hVw5cPBDe"
Content-Disposition: inline
In-Reply-To: <20170323173928.14439-9-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 08/10] blockjob: introduce
 block_job_cancel_async
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, jcody@redhat.com, jsnow@redhat.com


--1y1tiN5hVw5cPBDe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 23, 2017 at 06:39:26PM +0100, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  blockjob.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--1y1tiN5hVw5cPBDe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY61IuAAoJEJykq7OBq3PITtkH/AhMIvkGbm5pgMV+8eEHxDx1
mq4WEBFrcWzE+ClaEAPAq0FH+qfN2jj5DUGDSa64cSq4NVnfE1PEyBd34UQbuTuV
eIWoLF2x7poWBoPfZGX2Gn/um54UcBWnKcajYhEyu5o0PSeaBm+MSd15jTKLVuHP
XauUhxEtF7nfdtn9JkaQQ4UcROHf4hlwDnA1qn8QNCqfyL1veKBYzi7151NyjMv8
GIMdjK7FQbh38DJSerwBuUb+MjDqE/+YSwHdpoLtqL0bYMN2cw4LkjU9xMjJIcUs
MHhD2oF3tcTflzK4z5cw9FZKzc184Sg5aKJgzitgejrexxklf/L49KExj2OeyO4=
=wqNr
-----END PGP SIGNATURE-----

--1y1tiN5hVw5cPBDe--
