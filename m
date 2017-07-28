Received: from eggs.gnu.org ([2001:4830:134:3::10]:34120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dazFB-0001wo-5b
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 02:59:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dazF9-0006nB-9p
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 02:59:29 -0400
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-5-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a692e098-3491-1e4c-e5af-68bc2bf4e81c@redhat.com>
Date: Fri, 28 Jul 2017 08:59:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170728053610.15770-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/47] MAINTAINERS: add missing USB entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 28.07.2017 07:35, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f10252c292..3b472d7a09 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1008,6 +1008,7 @@ F: docs/usb2.txt
>  F: docs/usb-storage.txt
>  F: include/hw/usb.h
>  F: include/hw/usb/
> +F: default-configs/usb.mak
> =20
>  USB (serial adapter)
>  M: Gerd Hoffmann <kraxel@redhat.com>
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
