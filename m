Received: from eggs.gnu.org ([2001:4830:134:3::10]:50662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dKRp0-0003xX-UE
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 12:04:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dKRox-0008Ug-Kh
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 12:04:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dKRox-0008SY-FW
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 12:04:03 -0400
References: <20170612121820.31106-1-otubo@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ca7bce93-6a7e-3560-a6d9-ad95c2dc1eae@redhat.com>
Date: Mon, 12 Jun 2017 18:03:53 +0200
MIME-Version: 1.0
In-Reply-To: <20170612121820.31106-1-otubo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: seccomp: change email contact
 for Eduardo Otubo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

On 12.06.2017 14:18, Eduardo Otubo wrote:
> Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 120788d..0d065a0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1490,7 +1490,7 @@ F: tests/vmstate-static-checker-data/
>  F: docs/migration.txt
> =20
>  Seccomp
> -M: Eduardo Otubo <eduardo.otubo@profitbricks.com>
> +M: Eduardo Otubo <otubo@redhat.com>
>  S: Supported
>  F: qemu-seccomp.c
>  F: include/sysemu/seccomp.h

Reviewed-by: Thomas Huth <thuth@redhat.com>
