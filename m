Received: from eggs.gnu.org ([2001:4830:134:3::10]:41222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dayaQ-0004ms-4t
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 02:17:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dayaP-0008R9-Az
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 02:17:22 -0400
Date: Fri, 28 Jul 2017 14:17:10 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170728061710.GP5117@lemon.lan>
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-41-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170728053610.15770-41-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 40/47] MAINTAINERS: add missing entry for
 AIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-block@nongnu.org

On Fri, 07/28 02:36, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 83597fca4e..fb6a82c1ad 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1253,6 +1253,7 @@ F: util/aio-*.c
>  F: block/io.c
>  F: migration/block*
>  F: include/block/aio.h
> +F: scripts/qemugdb/aio.py
>  T: git git://github.com/stefanha/qemu.git block
> =20
>  Block Jobs
> --=20
> 2.13.3
>=20

Acked-by: Fam Zheng <famz@redhat.com>
