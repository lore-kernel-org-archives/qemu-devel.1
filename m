Received: from eggs.gnu.org ([2001:4830:134:3::10]:43451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dazUz-0003pc-4T
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 03:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dazUw-0001Bk-0J
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 03:15:49 -0400
Date: Fri, 28 Jul 2017 09:15:41 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170728091541.3d2c1e3b@gondolin>
In-Reply-To: <20170728053610.15770-12-f4bug@amsat.org>
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-12-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 11/47] MAINTAINERS: add missing entry for
 virtio/ccw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On Fri, 28 Jul 2017 02:35:34 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2958dd2479..bfdb2f8928 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1075,6 +1075,7 @@ M: Cornelia Huck <cohuck@redhat.com>
>  M: Christian Borntraeger <borntraeger@de.ibm.com>
>  S: Supported
>  F: hw/s390x/virtio-ccw.[hc]
> +F: include/standard-headers/asm-s390/virtio-ccw.h
>  T: git git://github.com/cohuck/qemu.git s390-next
>  T: git git://github.com/borntraeger/qemu.git s390-next
> =20

This one is also a linux header and should not be added to MAINTAINERS.
